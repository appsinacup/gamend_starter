import Config

# .env is already loaded by config.exs during config evaluation; this is
# kept as a safety net. (Code.require_file is a no-op when the file was
# already required.)
if config_env() == :dev do
  Code.require_file("dotenv.exs", __DIR__)
  Gamend.Dotenv.load(Path.expand("../.env", __DIR__))
end

# Every runtime derivation core ships: declared settings read from the
# environment plus the translation into the shapes Phoenix, Ecto, Bandit,
# Swoosh and Pigeon expect (Repo, Endpoint, mailer, cache, TLS, push, …).
# This used to be a 693-line fork of core's runtime config that lacked exactly
# that translation after slimming; GamendWeb.HostRuntime owns it now, so
# it arrives with a dep bump instead of a hand-copied block.
for entry <-
      GamendWeb.HostRuntime.config(config_env(), host_root: Path.expand("..", __DIR__)) do
  case entry do
    {app, opts} -> config app, opts
    {app, key, value} -> config app, key, value
  end
end

