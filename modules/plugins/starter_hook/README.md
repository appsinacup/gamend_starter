# Example hook plugin

This is a minimal OTP hook plugin example.

## Demo content

On its first boot (no accounts and no leaderboards yet) the plugin's
`after_startup/0` makes:

- **Leaderboards**: High Scores (`demo_scores`, each player's best) and Team
  Standings (`demo_teams`, labels instead of players, points add up)
- **Quests**: Welcome aboard (log in, paid at once), Set a high score (after
  the first, claimed by hand) and Say hello (3 chat messages, daily)
- **Tournament**: Weekly Cup (`demo_weekly_cup`, 8 players, drawn every
  Saturday at 18:00 UTC)

A server already in use gets none of it, and what an admin deletes stays
deleted. A client puts the caller's score on High Scores with
`starter_hook.submit_demo_score(1200)`. Delete `after_startup/0` for a server
that starts empty.

## Build

From the repo root:

- `cd modules/plugins/starter_hook`
- `mix deps.get`
- `mix compile`

This compiles the plugin into `_build/dev/lib/starter_hook/ebin/` (and generates the `.app` file with `hooks_module`).

## Package (plugin bundle)

The server loads plugins from a directory containing an `ebin/` folder.
To create a bundle directory you can drop into `modules/plugins/`:

- `mix plugin.bundle`

This also copies compiled dependency BEAMs into `deps/<dep>/ebin` (excluding `gamend_sdk`) so the server can load them if they are not already available in the server release.

## Run locally

- Set `GAMEND_CONTENT_PLUGINS_DIR=modules/plugins` (or copy the built bundle into `modules/plugins/starter_hook`)
- Open the Admin Config page and click **Reload plugins**
- Call a function via the “Hooks - Test RPC” form using:
  - `plugin`: `starter_hook`
  - `fn`: `hello` (or `set_current_user_meta`)
