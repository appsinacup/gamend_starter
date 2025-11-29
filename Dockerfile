FROM ghcr.io/appsinacup/game_server:latest

WORKDIR /app

COPY modules/ ./modules/
