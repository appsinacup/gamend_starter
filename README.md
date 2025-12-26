# Gamend Starter

## Run locally

1. Configure `.env` file (copy `.env.example` to `.env`).
2. Run the following:

```sh
docker compose up
```

You should now see on `localhost:4000`:

![example](./docs/example.png)

# Multi-node local deployment

For multi-node deployment, you need Postgres, a scalable `app` service (Elixir nodes), and an `nginx` proxy that load-balances requests to the app replicas.

1. Configure `.env` file (copy `.env.example` to `.env`).

2. Start services with 2 app replicas:

```sh
docker compose -f docker-compose.multi.yml up --build --scale app=2
```

## Configure

You can configure the:
- `starter_config.json`: This has settings in webpage (eg. titles), along the reference images and css it has.
- `starter_hook.ex`: This has custom logic you can write to extend default behaviours.
- `.env`: This contains secrets (eg. oauth/email/etc.)
- `apps/game_server_web/priv/static/assets/css/theme/theme.css`: The theme.
- `apps/game_server_web/priv/static/images`: The images used in website.

## Module Elixir Highlight

Run locally:

```sh
cd modules/plugins/starter_hook
mix deps.get
mix deps.compile
```

## Deploy

1. Fork this repo.
2. Go to fly.io (or another docker provider).
3. Connect the app with the repo you forked.
4. Launch the app and set your secrets.
