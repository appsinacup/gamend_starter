![gamend banner](https://github.com/appsinacup/game_server/blob/main/apps/game_server_web/priv/static/images/banner.png?raw=true)

-----

**Open source _game server_ with _authentication, users, lobbies, server scripting and an admin portal_.**

Game + Backend = Gamend

-----

[Discord](https://discord.com/invite/56dMud8HYn) | [Elixir Docs](https://appsinacup.github.io/game_server/) | [API Docs](https://gamend.appsinacup.com/api/docs) | [Guides](https://gamend.appsinacup.com/docs/setup) | [Deployment Tutorial](https://appsinacup.com/gamend-deploy/) | [Scaling Article](https://appsinacup.com/gamend-scaling/)

# Run locally

1. Configure `.env` file (copy `.env.example` to `.env`).
2. Run the following:

```sh
docker compose up
```

You should now see on `localhost:4000`:

![example](./docs/example.png)

## Multi-node local deployment

For multi-node deployment, you need Postgres, Redis, a scalable `app` service (Elixir nodes), and an `nginx` proxy that load-balances requests to the app replicas.

1. Configure `.env` file (copy `.env.example` to `.env`).

2. Start services with 2 app replicas:

```sh
docker compose -f docker-compose.multi.yml up --scale app=2
```

## Configure

You can configure the:
- `starter_config.json`: This has settings in webpage (eg. titles), along the reference images and css it has.
- `starter_hook.ex`: This has custom logic you can write to extend default behaviours.
- `.env`: This contains secrets (eg. oauth/email/etc.)
- `apps/game_server_web/priv/static/assets/css/theme/theme.css`: The theme.
- `apps/game_server_web/priv/static/images`: The images used in website.

## Module Elixir Highlight (compilation)

Run:

```sh
cd modules/plugins/starter_hook
mix deps.get
mix deps.compile
```

Note: This can also be done from the admin console.

# Deploy

1. Fork this repo.
2. Go to fly.io (or another docker provider).
3. Connect the app with the repo you forked.
4. Launch the app and set your secrets.
