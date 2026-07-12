# Gamend Starter — Godot client

A minimal Godot project that talks to your Gamend server: device login, fetch the
current user, and call the example `starter_hook.hello` server function over
**HTTP**, **WebSocket**, and **WebRTC**.

## Prerequisites

- **Godot 4.7+** (this project uses the GL Compatibility renderer).
- A running Gamend server — see the repository `README.md` ("Run locally":
  `mix dev.start`, or `docker compose up`).

## 1. Install the Gamend SDK

The `addons/` folder is **git-ignored** (not committed), so a fresh clone has no
SDK. Install the Gamend Godot SDK — it provides `addons/gamend` (the API client)
and `addons/phoenix_channels` (realtime):

- **Asset Library (recommended):** open this project in Godot → **AssetLib** tab
  → search **"Gamend SDK"** → Download → Install. Web page:
  <https://store.godotengine.org/asset/appsinacup/gamend-sdk/>
- **Or from releases:** download `godot_addons.zip` from
  <https://github.com/appsinacup/game_server/releases/tag/latest> and extract its
  `addons/gamend` and `addons/phoenix_channels` into `godot/addons/`.

## 2. (Desktop only) Install WebRTC

The **WebRTC** buttons need Godot's native WebRTC GDExtension on desktop builds
(web exports already ship with WebRTC). Download
`godot-extension-webrtc_native.zip` from
<https://github.com/godotengine/webrtc-native/releases> and extract its
`addons/webrtc_native` into `godot/addons/`. Skip this if you only use HTTP and
WebSocket.

## 3. Point at your server

`test_script.gd` exposes these on the scene root (edit in the Inspector, or change
the defaults):

| Export | Default | Notes |
| --- | --- | --- |
| `server_host` | `localhost` | Your server host |
| `server_port` | `4000` | HTTP port |
| `server_tls` | `false` | `true` for HTTPS/WSS |

Defaults match a local server (`mix dev.start` / `docker compose up`). For
production use e.g. `gamend.appsinacup.com`, `443`, `true`.

## 4. Run

Open `godot/project.godot` in Godot 4.7+ and press **Play** (F5). The demo logs
in with device auth, shows your user, and the three rows of buttons call
`starter_hook.hello("World")` over each transport.

## Notes

- For the hello call to return a value, the **`starter_hook` example plugin must
  be loaded on the server** (the Docker build compiles plugins automatically; for
  bare `mix dev.start` see the repo `README.md` → Configure).
- `addons/` is intentionally git-ignored — reinstall it after cloning. It is
  vendored per-project, not committed.
