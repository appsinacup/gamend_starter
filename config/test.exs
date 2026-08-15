import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
# Use PostgreSQL if environment variables are set, otherwise use SQLite
if System.get_env("GAMEND_DB_URL") ||
     (System.get_env("GAMEND_DB_POSTGRES_HOST") && System.get_env("GAMEND_DB_POSTGRES_USER")) do
  # Use PostgreSQL when configured
  database_url =
    System.get_env("GAMEND_DB_URL") ||
      "ecto://#{System.get_env("GAMEND_DB_POSTGRES_USER")}:#{System.get_env("GAMEND_DB_POSTGRES_PASSWORD")}@#{System.get_env("GAMEND_DB_POSTGRES_HOST")}:#{System.get_env("GAMEND_DB_POSTGRES_PORT", "5432")}/#{System.get_env("GAMEND_DB_POSTGRES_DB", "gamend_test")}"

  config :gamend_core, Gamend.Repo,
    url: database_url,
    adapter: Ecto.Adapters.Postgres,
    pool: Ecto.Adapters.SQL.Sandbox,
    pool_size: System.schedulers_online() * 2,
    pool_timeout: 10_000,
    queue_target: 10_000,
    queue_interval: 1_000,
    timeout: 15_000
else
  # Fallback to SQLite when no PostgreSQL config
  database_path =
    Path.expand(
      "../db/game_server_test#{System.get_env("MIX_TEST_PARTITION")}.db",
      __DIR__
    )

  File.mkdir_p!(Path.dirname(database_path))

  config :gamend_core, Gamend.Repo,
    database: database_path,
    adapter: Ecto.Adapters.SQLite3,
    # Match production: see the note in core's config/host_runtime.exs.
    default_transaction_mode: :immediate,
    pool: Ecto.Adapters.SQL.Sandbox,
    # Oban runs a boot-time `verify_migrated!` outside the sandbox while the
    # host tree's periodic DB workers hold connections alongside it. Two left
    # nothing spare: checkouts were dropped after ~20s before a single test ran
    # and Oban never started. Five is what the same tree needs elsewhere.
    pool_size: 5,
    # Boot-time seeding on a FRESH test DB runs minutes (bulk rows); the
    # sandbox pool's default 120s ownership timeout killed it.
    ownership_timeout: 600_000,
    pool_timeout: 10_000,
    queue_target: 10_000,
    queue_interval: 1_000,
    timeout: 15_000,
    # Top-level options, not a `pragmas:` list — ecto_sqlite3 has no such key
    # and silently ignores it.
    foreign_keys: :on,
    journal_mode: :wal,
    synchronous: :normal,
    temp_store: :memory,
    busy_timeout: 10_000
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gamend_web, GamendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "dJoNJZBOt08JlBREyPV5xvuOdwgHPORxK9WHp/k3Cs+g0R9ctyheJ8/CMeg/AdI1",
  server: false

# In test we don't send emails
config :gamend_core, Gamend.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Disable Sentry during testing
config :sentry,
  dsn: nil

# Print only warnings and errors during test
config :logger, level: :warning

# Disable app-level caching in tests to avoid stale reads across assertions.
# Still provide the multilevel configuration so the cache can start.
config :gamend_core, Gamend.Cache,
  bypass_mode: true,
  inclusion_policy: :inclusive,
  levels: [
    {Gamend.Cache.L1, []}
  ]

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Configure Guardian for testing
config :gamend_web, GamendWeb.Auth.Guardian,
  issuer: "gamend",
  secret_key: "dJoNJZBOt08JlBREyPV5xvuOdwgHPORxK9WHp/k3Cs+g0R9ctyheJ8/CMeg/AdI1",
  ttl: {15, :minutes}

# Disable rate limiting in tests
config :gamend_web, GamendWeb.Plugs.RateLimiter, enabled: false

# Oban runs inline in tests; use Oban.Testing helpers to drain when needed.
config :gamend_core, Oban, testing: :manual
