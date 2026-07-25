import Config

# .env is already loaded by config.exs during config evaluation; this is
# kept as a safety net. (Code.require_file is a no-op when the file was
# already required.)
if config_env() == :dev do
  Code.require_file("dotenv.exs", __DIR__)
  GameServer.Dotenv.load(Path.expand("../.env", __DIR__))
end

# Every setting core and this host declare, read from the environment once at
# boot. This used to be a 693-line fork of core's runtime config; declarations
# now ship with the dependency, so a setting added upstream arrives with a dep
# bump instead of a hand-copied block.
for {app, module, opts} <- GameServer.Settings.from_env() do
  config app, module, opts
end

# The starter ships a packaged theme, used unless the operator points somewhere
# else. Set after from_env/0 so an explicit value always wins.
unless GameServer.Settings.get(GameServer.ContentSettings, :theme_config) do
  config :game_server_core, GameServer.ContentSettings,
    theme_config: Path.expand("../modules/starter_config.json", __DIR__)
end
