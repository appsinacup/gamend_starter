# syntax=docker/dockerfile:1
# Two images from one file.
#
#   docker build .                      → dev: what `docker compose up` runs
#   docker build --target release .     → an OTP release, for production and
#                                          for Gamend Cloud
#
# The system packages, Rust, Hex and the start commands are not here: they are
# Gamend's base images (github.com/appsinacup/gamend, docker/README.md), so a
# new Elixir or a new system library arrives with them.
#
# The adapter is a compile-time choice, so an image is specific to one:
#
#   docker build --target release --build-arg GAMEND_DB_ADAPTER=postgres .

ARG BUILDER_IMAGE=ghcr.io/appsinacup/gamend-builder:elixir-1.20
# Tracks the builder's Debian release: the release carries ERTS and NIFs linked
# against that libc.
ARG RUNNER_IMAGE=ghcr.io/appsinacup/gamend-runtime:trixie

ARG GAMEND_DB_ADAPTER=sqlite
# Server plugins (hooks) shipped in this repo, found here at runtime.
ARG GAMEND_CONTENT_PLUGINS_DIR=modules/plugins

# No GAMEND_CONTENT_APP_VERSION in this file, as an ARG or an ENV: gamend's own
# mix.exs reads it as the engine's package version, so exporting it while the
# deps compile builds gamend_core/gamend_web as that version, and mix.exs's
# @gamend_min floor then rejects them. Set it at runtime instead.

# ── Builder (prod) ────────────────────────────────────────────────────────
FROM ${BUILDER_IMAGE} AS builder

ENV MIX_ENV=prod

ARG GAMEND_DB_ADAPTER
ENV GAMEND_DB_ADAPTER=${GAMEND_DB_ADAPTER}

ARG GAMEND_CONTENT_PLUGINS_DIR
ENV GAMEND_CONTENT_PLUGINS_DIR=${GAMEND_CONTENT_PLUGINS_DIR}

# Dependencies in their own layers, so a change to lib/ does not compile them
# again. Compile-time config first: some deps read it (mdex's highlighter).
COPY mix.exs mix.lock ./
RUN mix deps.get
COPY config config
RUN mix deps.compile

COPY . .
RUN mix deps.get

# Compile and bundle each shipped plugin, so the server finds its <name>.app
# and loads its hooks.
RUN gamend-build-plugins --verbose

RUN mix compile
RUN mix assets.deploy
# The digested assets into the release.
RUN gamend-copy-static gamend_host --require

# ── Release ───────────────────────────────────────────────────────────────
FROM builder AS release-build

RUN mix release --overwrite
RUN echo -n "$(git rev-parse --short HEAD 2>/dev/null || echo unknown)" > /app/VERSION
RUN mkdir -p "${GAMEND_CONTENT_PLUGINS_DIR}"

FROM ${RUNNER_IMAGE} AS release

# The adapter is chosen twice, baked in at compile time and read again at
# boot, and the two must agree; the plugins directory is read at boot.
ARG GAMEND_DB_ADAPTER
ARG GAMEND_CONTENT_PLUGINS_DIR
ENV GAMEND_DB_ADAPTER=${GAMEND_DB_ADAPTER} \
    GAMEND_CONTENT_PLUGINS_DIR=${GAMEND_CONTENT_PLUGINS_DIR}

COPY --from=release-build /app/_build/prod/rel/gamend_host ./
COPY --from=release-build /app/VERSION ./VERSION
# Read at boot from where the build had them (config/config.exs): the site's
# config and its pictures, the changelog, roadmap and blog, and the plugins.
# None of them is part of the OTP release.
COPY --from=release-build /app/modules ./modules
COPY --from=release-build /app/content ./content

EXPOSE 4000 443

# Raise the open-files limit, create and migrate the database, start.
CMD ["gamend-release-start", "gamend_host"]

# ── Dev (default target) ──────────────────────────────────────────────────
# Last, so `docker build .` and `docker compose up` build it: MIX_ENV=dev,
# with each plugin's lib/ mounted for live editing (docker-compose.yml).
FROM ${BUILDER_IMAGE} AS dev

ARG MIX_ENV=dev
ENV MIX_ENV=${MIX_ENV}

ARG GAMEND_DB_ADAPTER
ENV GAMEND_DB_ADAPTER=${GAMEND_DB_ADAPTER}

ARG GAMEND_CONTENT_PLUGINS_DIR
ENV GAMEND_CONTENT_PLUGINS_DIR=${GAMEND_CONTENT_PLUGINS_DIR}

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY . .
RUN mix deps.get
RUN gamend-build-plugins --verbose
RUN mix compile
RUN mix assets.setup && mix assets.build

# Rebuild every plugin at start, which is how an edit to a mounted lib/ reaches
# the server (a no-op when nothing changed).
ENV GAMEND_START_PLUGINS=1

EXPOSE 4000

# Create and migrate the database, then serve (the base image's command).
CMD ["gamend-start"]
