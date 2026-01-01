# godot_hook

Hook plugin that starts a Godot instance and forwards Gamend hook callbacks to it over WebSocket.

```text
  +--------------------+
  | GameServer/Gamend  |
  +--------------------+
            |
            | calls hooks (WebSocket)
            | 
            v
  +--------------------+
  | godot_hook plugin  |
  | (spawns Godot)     |
  | ( WS client)       |
  +--------------------+
            |
            | sends and receives hooks through Websocket Client
            v
  +--------------------+
  | Godot headless     |
  | (starts WS server) |
  +--------------------+
```

This plugin is an OTP application (`:godot_hook`). When it is started, it starts a supervisor which starts `GodotHook.GodotManager`.

`GodotHook.GodotManager` will auto-start Godot in `init/1` when `:autostart` is true.

## Concurrency model

- Per Elixir node (per running release/container), this plugin starts a single `GodotHook.GodotManager`, a single `GodotHook.WSClient`, and (by default) a single headless Godot OS process.
- Hook payloads are sent over a single WebSocket connection.
- Synchronous hooks (`call`-style) can have multiple in-flight RPCs concurrently over that one WebSocket connection (each request includes a `request_id` and responses are matched back).

## Configuration

Environment variables (recommended):

- `GODOT_BIN` – path to the Godot executable
- `GODOT_PROJECT_PATH` – path to the Godot project directory
- `GODOT_WS_URL` – where Gamend should connect over WebSocket (default: `ws://127.0.0.1:4010`)
- `GODOT_ARGS` – extra args appended to the Godot command (space-separated)

If you build via this repo's Dockerfile, Godot is installed into the image and `GODOT_BIN` defaults to `/opt/godot/godot`.

## Build

From repo root:

```sh
cd modules/plugins/godot_hook
mix deps.get
mix compile
```

To create a bundle directory you can drop into `modules/plugins/`:

```sh
mix plugin.bundle
```

## Godot side (receiver)

Godot needs to run a WebSocket server and accept JSON text frames matching:

```json
{
  "hook": "after_user_register",
  "args": [{"apple_id": null, "authenticated_at": null, "confirmed_at": "2025-12-31T16:57:14Z", "device_id": null, "discord_id": null, "display_name": null, "email": "example@yahoo.com", "facebook_id": null, "google_id": null, "id": 1.0, "inserted_at": "2025-12-31T16:57:14Z", "is_admin": true, "lobby_id": null, "profile_url": null, "steam_id": null, "updated_at": "2025-12-31T16:57:14Z"}],
  "meta": {"caller": "..."},
  "at": "2025-12-30T12:34:56Z"
}
```
