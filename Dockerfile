FROM ghcr.io/appsinacup/game_server:latest

WORKDIR /app

COPY modules/ ./modules/
COPY priv/static/assets/css/theme/ ./priv/static/assets/css/theme/
COPY priv/static/images/ ./priv/static/images/

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
