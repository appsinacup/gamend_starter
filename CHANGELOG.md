# September 2026

- [changed] **gamend from Hex, or from a sibling checkout** — `gamend_core` and `gamend_web` resolve to Hex `~> 1.0`, or to `../gamend` when that checkout exists, so engine edits show up here without a push. The plugins use Hex `gamend_sdk` and `gamend_plugin_tools`.
- [changed] **Content pages come from core** — `/blog`, `/changelog` and `/roadmap` route to core's LiveViews; the host's own copies are removed.
- [added] **Search palette provider** — `lib/gamend_host/search.ex` adds this host's pages to search, and a test checks that every link it returns routes.
- [fixed] **Branding loads** — the theme file is `modules/starter_config.json`, the one path the config reads; it was named `starter_config.en.json` and silently ignored.
- [fixed] **`mix precommit` fails on compile warnings** — the flag was misspelled `--warning-as-errors`.
- [removed] **`Dockerfile.postgres`** — the main `Dockerfile` builds for Postgres with `--build-arg GAMEND_DB_ADAPTER=postgres`, which the multi-node compose file now passes.
- [fixed] **`Dockerfile.godot`** builds on this starter's own image with Godot 4.7.2; it copied paths from the old overlay layout that no longer exist.
- [fixed] **Multi-node compose** mounts `priv/static/theme.css`, the theme this host serves.
- [added] `AGENTS.md`, with `CLAUDE.md` importing it: the layout, commands and gotchas for anyone editing this repository.

# August 2026

- [added] **CI** — format, credo, `deps.audit`, dialyzer, a warnings-as-errors compile, the test suite on SQLite, and a Docker build, on every push and pull request.
- [changed] **Dependencies match gamend's** — shared deps are pinned to the versions gamend uses, and the ones this host never called are removed. `.formatter.exs` is anchored at this project, so `mix format` no longer reaches into sibling checkouts.

# July 2026

- [breaking] **Gamend naming** — modules, plugins and seeds move from `GameServer` to `Gamend`; a plugin's hook module is `Gamend.Modules.<Name>`.
- [breaking] **Namespaced settings** — every env var is `GAMEND_*`; see `.env.example`.
- [changed] **Shared router and runtime config** — the router calls core's `GamendWeb.Router.Shared` macros instead of copying core's route table, and `config/runtime.exs` is one loop over `GamendWeb.HostRuntime`.
- [added] **Data retention** — lobbies everyone has gone quiet in (never around a reconnect), expired auth tokens, resolved invites and matchmaking tickets are now pruned on a schedule; windows are `GAMEND_RETENTION_*` env vars (see `.env.example`), and Admin -> System shows the last run with a "Run now" action.
- [added] **Lobby state** — server-owned `state` + `state_changed_at` on lobbies, `POST /lobbies/state` for hosts, and the `before_lobby_state_change` / `after_lobby_state_changed` hooks.
- [added] **Quests / progression** — routes for `/me/quests`, claim, catalog and admin CRUD; the `/quests` page and `/admin/quests` come from core.
- [breaking] **Achievements removed** — replaced by permanent quests categorised `"achievement"`. The `/achievements` routes, page and Godot `AchievementsApi` are gone; use the quest equivalents.
- [added] **Lobby snapshots** — durable per-run record of lobby state, opt-in via `GAMEND_LOBBY_SNAPSHOTS_ENABLED`.
- [added] **Matchmaking** (ticket queue), admin page and hooks.
- [added] **Party matchmaking**, matched as one unit.
- [added] **Tournaments** (bracket system).
- [added] **User blacklist**, enforced in matchmaking and lobbies.
- [added] **Admin runtime page**: hooks, env vars, protobuf, channels, events, ER diagram, plugins, jobs.
- [added] Realtime update debounce (`GAMEND_REALTIME_DEBOUNCE_MS`).
- [added] Protobuf realtime format (opt-in).
- [removed] Dead modules and client delta code.
- [added] **Unique usernames**.
- [breaking] **UUIDv7 string ids**.
- [added] JWT revocation.
- [added] Persistent IP bans.
- [added] Redis rate limiting.
- [added] Data retention pruning.
- [added] New plugin hooks.
- [added] Observability metrics.
- [security] Auth, payments, RPC hardening.
- [perf] Faster broadcasts and queries.
- [fixed] WebRTC RPC replies.

# April 2026

- [changed] Root host app restructure.
- [added] Browser theme color, sitemap.xml, robots.txt.
- [added] **Native HTTPS**
- [added] **Account Activation** beta mode.
- [added] Translations: Spanish, French, Romanian.
- [added] Roadmap page.
- [added] Security: RealIp, IP bans, OAuth CSRF, rate limiting, WebRTC - limits, security headers.
- [added] **OPENAPI_ENABLED** feature gate.

# March 2026

- [changed] Make Leaderboards accept label instead of user_id.
- [added] Initial version of **Achievements**.
- [added] Initial version of **Rate Limiting**.
- [changed] Self-hosted Inter font and eliminated all inline scripts.
- [added] Initial version of **WebSocket** updates.
- [added] Initial version of **WebRTC** updates.
- [changed] Admin interface with realtime connections view.

# Feb 2026

- [added] Initial version of **CHANGELOG** and **Blog**.
- [added] Initial version of **Groups**.
- [added] Initial version of **Parties**.
- [added] Initial version of **Notifications**.
- [added] Initial version of **Chat**.
