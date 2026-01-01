FROM ghcr.io/appsinacup/game_server:latest

WORKDIR /app

# Install Godot inside the container so plugins don't require GODOT_BIN at runtime.
#
# Notes:
# - Uses official Godot release ZIPs.
# - Selects the correct binary for the target arch (amd64 vs arm64).
# - You still need to provide GODOT_PROJECT_PATH (path to your Godot project inside the container).
ARG GODOT_RELEASE=4.5.1-stable
ENV GODOT_BIN=/opt/godot/godot
# Default Godot project path inside the container (copied below)
ENV GODOT_PROJECT_PATH=/app/godot

RUN set -eux; \
	# Install download tools (base image may be Debian/Ubuntu or Alpine)
	if command -v apt-get >/dev/null 2>&1; then \
		apt-get update; \
		apt-get install -y --no-install-recommends ca-certificates curl unzip libfontconfig1; \
		rm -rf /var/lib/apt/lists/*; \
	elif command -v apk >/dev/null 2>&1; then \
		# Godot Linux binaries/templates are built against glibc; on Alpine (musl)
		# we need compat packages so the loader exists.
		apk add --no-cache ca-certificates curl unzip fontconfig gcompat libc6-compat libstdc++; \
	else \
		echo "Unsupported base image: need apt-get or apk"; \
		exit 1; \
	fi

RUN set -eux; \
	arch="$(uname -m)"; \
	case "$arch" in \
		x86_64|amd64) godot_arch="linux.x86_64" ;; \
		aarch64|arm64) godot_arch="linux.arm64" ;; \
		*) echo "Unsupported arch: $arch"; exit 1 ;; \
	esac; \
	url="https://github.com/godotengine/godot/releases/download/${GODOT_RELEASE}/Godot_v${GODOT_RELEASE}_${godot_arch}.zip"; \
	mkdir -p /opt/godot; \
	curl -fsSL "$url" -o /tmp/godot.zip; \
	unzip -q /tmp/godot.zip -d /opt/godot; \
	rm -f /tmp/godot.zip; \
	# The zip extracts a versioned binary name; normalize to /opt/godot/godot
	found_bin="$(find /opt/godot -maxdepth 1 -type f -name 'Godot_v*_linux.*' | head -n 1)"; \
	if [ -z "$found_bin" ]; then \
		echo "Godot binary not found after unzip"; \
		ls -la /opt/godot; \
		exit 1; \
	fi; \
	mv "$found_bin" /opt/godot/godot; \
	chmod +x /opt/godot/godot; \
	/opt/godot/godot --version || true

RUN set -eux; \
	# Install export templates so headless exports work.
	# Godot expects: /root/.local/share/godot/export_templates/<version>/*.linux_*
	templates_url="https://github.com/godotengine/godot/releases/download/${GODOT_RELEASE}/Godot_v${GODOT_RELEASE}_export_templates.tpz"; \
	templates_zip="/tmp/godot_export_templates.tpz"; \
	curl -fsSL "$templates_url" -o "$templates_zip"; \
	# Basic sanity check: archive should be a valid zip.
	unzip -t "$templates_zip" >/dev/null; \
	templates_version_dir="$(printf '%s' "$GODOT_RELEASE" | tr '-' '.')"; \
	templates_dest="/root/.local/share/godot/export_templates/${templates_version_dir}"; \
	mkdir -p "$templates_dest"; \
	rm -rf /tmp/godot_templates; \
	mkdir -p /tmp/godot_templates; \
	unzip -q "$templates_zip" -d /tmp/godot_templates; \
	# The tpz contains a top-level templates/ directory.
	if [ ! -d /tmp/godot_templates/templates ]; then \
		echo "Godot templates archive did not contain templates/"; \
		find /tmp/godot_templates -maxdepth 2 -type d -print; \
		exit 1; \
	fi; \
	cp -a /tmp/godot_templates/templates/. "$templates_dest"/; \
	rm -rf /tmp/godot_templates "$templates_zip"; \
	# Sanity check a couple expected files for the current arch.
	find "$templates_dest" -maxdepth 1 -type f -name 'linux_*' | head -n 20 || true

COPY modules/ ./modules/
COPY godot/ ./godot/
COPY apps/game_server_web/priv/static/assets/css/theme/ ./apps/game_server_web/priv/static/assets/css/theme/
COPY apps/game_server_web/priv/static/images/ ./apps/game_server_web/priv/static/images/

# Build any plugins shipped in this repo (overlay) so they're available at runtime.
ARG GAME_SERVER_PLUGINS_DIR=modules/plugins
ENV GAME_SERVER_PLUGINS_DIR=${GAME_SERVER_PLUGINS_DIR}

RUN if [ -d "${GAME_SERVER_PLUGINS_DIR}" ]; then \
		for plugin_path in ${GAME_SERVER_PLUGINS_DIR}/*; do \
			if [ -d "${plugin_path}" ] && [ -f "${plugin_path}/mix.exs" ]; then \
				echo "Building plugin ${plugin_path}"; \
				(cd "${plugin_path}" && mix deps.get && mix compile && mix plugin.bundle); \
			fi; \
		done; \
	else \
		echo "Plugin sources dir ${GAME_SERVER_PLUGINS_DIR} missing, skipping plugin builds"; \
	fi
