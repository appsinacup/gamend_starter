import Config

# .env is already loaded by config.exs during config evaluation; this is
# kept as a safety net. (Code.require_file is a no-op when the file was
# already required.)
if config_env() == :dev do
  Code.require_file("dotenv.exs", __DIR__)
  GameServer.Dotenv.load(Path.expand("../.env", __DIR__))
end

# Every runtime derivation core ships: declared settings read from the
# environment plus the translation into the shapes Phoenix, Ecto, Bandit,
# Swoosh and Pigeon expect (Repo, Endpoint, mailer, cache, TLS, push, …).
# This used to be a 693-line fork of core's runtime config that lacked exactly
# that translation after slimming; GameServerWeb.HostRuntime owns it now, so
# it arrives with a dep bump instead of a hand-copied block.
for entry <-
      GameServerWeb.HostRuntime.config(config_env(), host_root: Path.expand("..", __DIR__)) do
  case entry do
    {app, opts} -> config app, opts
    {app, key, value} -> config app, key, value
  end
end

# The starter ships a packaged theme, used unless the operator points somewhere
# else. Checked against the resolved environment (not `Settings.get`, which
# cannot see what the loop above staged), so an explicit value always wins.
unless GameServer.Settings.resolve()[{GameServer.ContentSettings, :theme_config}] do
  config :game_server_core, GameServer.ContentSettings,
    theme_config: Path.expand("../modules/starter_config.json", __DIR__)
end
