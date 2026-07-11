FROM elixir:1.20-slim

# System deps: git (github deps), build tools + libssl/sqlite (native NIFs),
# curl (rust installer), ca-certificates.
RUN apt-get update && \
    apt-get install -y git build-essential libsqlite3-dev sqlite3 pkg-config ca-certificates curl libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Rust toolchain — required to build native NIFs (e.g. mdex_native).
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN mix local.hex --force && mix local.rebar --force

WORKDIR /app

# The compose file runs the app in dev; keep build and runtime env in sync.
ARG MIX_ENV=dev
ENV MIX_ENV=${MIX_ENV}

ARG DATABASE_ADAPTER=sqlite
ENV DATABASE_ADAPTER=${DATABASE_ADAPTER}

# Server plugins (hooks) shipped in this repo are discovered from here at
# runtime. Baked into the image below so they load without a build step.
ARG GAME_SERVER_PLUGINS_DIR=modules/plugins
ENV GAME_SERVER_PLUGINS_DIR=${GAME_SERVER_PLUGINS_DIR}

ARG APP_VERSION=1.0.0
ENV APP_VERSION=${APP_VERSION}

# Fetch top-level deps first for better layer caching.
COPY mix.exs mix.lock ./
COPY modules/plugins/starter_hook/mix.exs modules/plugins/starter_hook/mix.lock ./modules/plugins/starter_hook/
RUN mix deps.get

COPY . .
RUN mix deps.get

# Compile and bundle each shipped plugin so the server finds its <name>.app and
# loads the hooks (fixes "starter_hook.app not found" at runtime).
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

RUN mix compile
RUN mix assets.setup && mix assets.build

EXPOSE 4000

CMD ["sh", "-c", "mix ecto.create --quiet -r GameServer.Repo 2>/dev/null; mix db.migrate && mix phx.server"]
