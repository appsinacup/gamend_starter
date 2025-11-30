FROM ghcr.io/appsinacup/game_server:latest

WORKDIR /app

COPY modules/ ./modules/
COPY priv/static/assets/css/theme/ ./priv/static/assets/css/theme/
COPY priv/static/images/ ./priv/static/images/
