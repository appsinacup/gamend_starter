# July 2026

- [added] **Lobby snapshots** — durable per-run record of lobby state, opt-in via `LOBBY_SNAPSHOTS_ENABLED`.
- [added] **Matchmaking** (ticket queue), admin page and hooks.
- [added] **Party matchmaking**, matched as one unit.
- [breaking] Matchmaking join/cancel via HTTP.
- [changed] Tickets pruned after offline grace.
- [fixed] Duplicate tickets self-matching.
- [added] **Tournaments** (bracket system).
- [added] **User blacklist**, enforced in matchmaking and lobbies.
- [added] Admin blacklist page, `GET /me/blacklist`.
- [added] `bypass_lock` join option.
- [fixed] Party invites check every member's blocks.
- [fixed] Parties with a blocked pair refused at queue.
- [fixed] Lobby-scoped KV cleared on leave.
- [fixed] Default hooks shadowing plugin hooks.
- [added] **Admin runtime page**: hooks, env vars, protobuf, channels, events, ER diagram, plugins, jobs.
- [added] Player search on public pages.
- [added] Realtime update debounce (REALTIME_DEBOUNCE_MS).
- [added] Protobuf realtime format (opt-in).
- [added] `mix host.proto.gen` for Elixir/JS/Godot bindings.
- [added] **Plugin declarations**: `notification_types/0`, `realtime_events/0`, `env_vars/0`.
- [added] `GameServer.Realtime.push_to_user/3` for game-defined events.
- [added] `GameServer.Config.get/1,2` — typed env var reads, type from the default.
- [changed] Realtime state events send full payloads.
- [removed] JSON delta encoding.
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
