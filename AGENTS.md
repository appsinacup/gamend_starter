# Working in this repository

Gamend Starter: the host app people fork to run their own
[Gamend](https://github.com/appsinacup/gamend) game server (Elixir, Phoenix).
The engine (`gamend_core`, `gamend_web`) is a dependency. This repository owns
the routing, boot config, branding, content and server plugins around it.
`CLAUDE.md` imports this file; edit this one.

## Where things are

| File | What it holds |
| --- | --- |
| [README.md](README.md) | running it locally, in Docker, multi-node, and deploying |
| [CHANGELOG.md](CHANGELOG.md) | changes to this repository, `# Month YYYY` then `- [added\|changed\|fixed\|removed\|breaking] ...` |
| [content/CHANGELOG.md](content/CHANGELOG.md) | the player-facing changelog served at `/changelog` |
| [godot/README.md](godot/README.md) | the Godot demo client |
| [modules/plugins/starter_hook/README.md](modules/plugins/starter_hook/README.md) | the example server plugin |
| [gamend `AGENTS.md`](https://github.com/appsinacup/gamend/blob/main/AGENTS.md) | Elixir, Phoenix, LiveView and routing rules; they apply here too |
| [gamend `CONTRIBUTING.md`](https://github.com/appsinacup/gamend/blob/main/CONTRIBUTING.md) | hooks, settings, time rendering, the changelog line format |
| [gamend `RULES.md`](https://github.com/appsinacup/gamend/blob/main/RULES.md) | accessibility rules |
| [Guides](https://gamend.org/docs/setup), [API](https://gamend.org/api/docs), [Elixir docs](https://docs.gamend.org/) | the engine's published docs |

## Layout

Edit:

- `lib/gamend_host/router.ex` — core routes come from the
  `GamendWeb.Router.Shared` macros. Add host routes around them; never copy
  core's.
- `lib/gamend_host/application.ex` — the tree is
  `GamendWeb.HostSupervision.children/1`. Host processes go in
  `children(extra: [...])`.
- `lib/gamend_host/search.ex` — the search palette provider. Every href must
  route; `test/search_test.exs` checks it.
- `lib/gamend_web/` — host pages, named `GamendWeb.Host*` so core's scopes
  resolve them.
- `config/` — compile-time config. Runtime config is one loop over
  `GamendWeb.HostRuntime.config/2` in `config/runtime.exs`; add no
  per-setting blocks there.
- `modules/` — the theme JSON that `config/config.exs` points at, and one Mix
  project per server plugin under `modules/plugins/<name>/`.
- `content/` — `CHANGELOG.md`, `ROADMAP.md` and `blog/`, served at
  `/changelog`, `/roadmap` and `/blog`.
- `priv/static/theme.css`, `priv/static/images/`, `assets/css/app.css` —
  styling. Small token overrides go in `theme.css`.
- `godot/` — the Godot 4.7 demo client. `godot/addons/` is ignored.

Leave alone: `deps/`, `_build/`, each plugin's `deps/`, `_build/` and `ebin/`
(all generated), and `assets/vendor/`. Fix an engine bug in gamend rather than
copying an engine module here: every copy so far (router, supervision tree,
runtime config, content pages) drifted from the engine.

## Commands

    mix setup            # deps, database, assets
    mix dev.start        # create and migrate the database, build assets, serve on :4000
    mix test             # create and migrate the test database, then test
    mix lint             # format --check-formatted, credo --strict
    mix precommit        # compile, format, test, credo --strict, gamend.api.lint
    mix precommit.full   # precommit, the engine web app's checks, deps.audit
    mix db.migrate | mix db.rollback | mix db.setup | mix db.reset
    mix gamend.settings.env_example     # regenerate .env.example
    bin/update-deps [--check] [dep...]  # every mix.lock, plugins included

A plugin builds on its own:
`cd modules/plugins/<name> && mix deps.get && mix compile && mix plugin.bundle`.
The server loads the bundled `ebin/`, so re-run `mix plugin.bundle` after an
edit.

CI (`.github/workflows/ci.yml`) runs `mix format --check-formatted`,
`mix credo --strict`, `mix deps.audit`, `MIX_ENV=dev mix dialyzer`,
`MIX_ENV=test mix compile --warnings-as-errors`, `mix test` on SQLite, and a
Docker build. Run the mix steps before pushing.

## How gamend is pulled in

- `shared_dep/2` in `mix.exs` uses a path dep when
  `../gamend/apps/<app>/mix.exs` exists, and Hex `~> 1.0` otherwise. The
  sibling directory must be named `gamend`.
- With the sibling, engine edits are live, and `mix test`, `mix lint` and
  `mix precommit.full` also run in `../gamend`. In that mode
  `mix test <file>` hands `<file>` to the gamend_web run, the alias's last
  step.
- Without it (a fresh clone, CI, Docker), gamend's CI publishes
  `1.0.<commit count>` on each green push to its `main`. Update with
  `mix deps.update gamend_core gamend_web`.
- Plugins always use Hex `gamend_sdk` and `gamend_plugin_tools`:
  `bin/update-deps gamend_sdk gamend_plugin_tools`.
- A change here that needs an engine change lands after the engine is
  published.

## Gotchas

- The database adapter is chosen at compile time. SQLite by default; for
  Postgres set `GAMEND_DB_POSTGRES_*` or `GAMEND_DB_URL`, then
  `mix deps.clean gamend_core gamend_web --build && mix compile`.
- `config :gamend_core, Oban, ...` in `config/config.exs` is read at boot.
  When the engine adds host config, mirror it from gamend's
  `config/host_config.exs`.
- `config/test.exs` keeps the SQLite pool at 5: Oban's boot check and the
  periodic workers starve a smaller one. Lower it only after turning those
  workers off in test, the way gamend's `config/test.exs` does.
- Each plugin is its own Mix project: a root `mix deps.get` or `mix format`
  does not reach it.
- The `host.*` Mix tasks ship in `gamend_core`. Keep no local copies.
- A new setting goes through the engine's `Gamend.Settings.Provider` with a
  `GAMEND_*` name, never `System.get_env`.
- Render an instant with `<.timestamp>`, never `Calendar.strftime`.
