defmodule GamendHost.Application do
  @moduledoc false

  use Application

  alias Gamend.Hooks.PluginManager
  alias Gamend.OAuth.Providers
  alias Gamend.Repo.AdvisoryLock
  alias GamendWeb.Auth.Tokens

  @impl true
  def start(_type, _args) do
    GamendWeb.HostSupervision.init_runtime()
    GamendHost.ContentPaths.register_defaults()

    # Core owns this list. This host used to keep its own copy and had drifted by
    # eight children — cache stats/sync, IP-ban mirroring, retention,
    # matchmaking, the lobby-snapshots writer — plus an unbounded task
    # supervisor. None of that errors when missing; it just silently does
    # nothing while the config still reads "on".
    children = GamendWeb.HostSupervision.children()

    opts = [strategy: :one_for_one, name: GamendHost.Supervisor]

    result = Supervisor.start_link(children, opts)

    log_startup_resources()

    result
  end

  @impl true
  def config_change(changed, _new, removed) do
    GamendWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp log_startup_resources do
    require Logger

    lines = [
      "=== Gamend startup resources ===",
      database_info(),
      cache_info(),
      mailer_info(),
      jwt_info(),
      oauth_info(),
      clustering_info(),
      sentry_info(),
      plugins_info(),
      channels_info(),
      endpoint_info()
    ]

    Logger.info(Enum.join(lines, "\n  "))
  end

  defp database_info do
    repo_config = Gamend.Repo.config()

    adapter_name = Gamend.Repo.__adapter__() |> inspect() |> String.split(".") |> List.last()

    mismatch =
      if AdvisoryLock.postgres?() == false &&
           (System.get_env("GAMEND_DB_URL") ||
              (System.get_env("GAMEND_DB_POSTGRES_HOST") &&
                 System.get_env("GAMEND_DB_POSTGRES_USER"))) do
        " [WARNING: Postgres env vars set but compiled with SQLite — rebuild with GAMEND_DB_ADAPTER=postgres]"
      else
        ""
      end

    db =
      cond do
        repo_config[:url] -> "(url configured)"
        repo_config[:database] -> repo_config[:database]
        true -> "(default)"
      end

    pool = repo_config[:pool_size] || "default"
    "Database: #{adapter_name} #{db} (pool: #{pool})#{mismatch}"
  end

  defp cache_info do
    cache_config = Application.get_env(:gamend_core, Gamend.Cache, [])
    bypass? = Keyword.get(cache_config, :bypass_mode, false)

    if bypass? do
      "Cache: disabled (bypass mode)"
    else
      l2_config = Keyword.get(cache_config, :l2, [])
      l2_adapter = Keyword.get(l2_config, :adapter)

      l2_name =
        case l2_adapter do
          NebulexRedisAdapter -> "Redis"
          Nebulex.Adapters.Partitioned -> "Partitioned"
          nil -> "L1 only"
          other -> inspect(other)
        end

      "Cache: enabled (L2: #{l2_name})"
    end
  end

  defp mailer_info do
    mailer_config = Application.get_env(:gamend_core, Gamend.Mailer, [])
    adapter = mailer_config[:adapter]

    case adapter do
      Swoosh.Adapters.SMTP ->
        relay = mailer_config[:relay] || "?"
        "Mailer: SMTP (#{relay})"

      Swoosh.Adapters.Local ->
        "Mailer: Local (in-memory, /dev/mailbox)"

      Swoosh.Adapters.Test ->
        "Mailer: Test adapter"

      nil ->
        "Mailer: not configured"

      other ->
        "Mailer: #{inspect(other)}"
    end
  end

  # The lifetimes are settings now (`GAMEND_AUTH_ACCESS_TOKEN_TTL_MINUTES`,
  # `GAMEND_AUTH_REFRESH_TOKEN_TTL_DAYS`); Guardian's `ttl` key is ignored.
  defp jwt_info do
    %{"access" => {access, access_unit}, "refresh" => {refresh, refresh_unit}} =
      Tokens.ttls()

    "JWT: Guardian (access TTL: #{access} #{access_unit}, refresh TTL: #{refresh} #{refresh_unit})"
  end

  defp oauth_info do
    case Providers.enabled() do
      [] ->
        "OAuth: none configured"

      providers ->
        "OAuth: #{Enum.map_join(providers, ", ", &String.capitalize(Atom.to_string(&1)))}"
    end
  end

  defp clustering_info do
    query = Application.get_env(:gamend_web, :dns_cluster_query)

    if query && query != :ignore do
      "Clustering: DNS (#{query})"
    else
      node = Node.self()

      if node == :nonode@nohost do
        "Clustering: standalone (no distribution)"
      else
        "Clustering: node #{node}"
      end
    end
  end

  # A DSN alone reports nothing: errors reach Sentry through its logger handler,
  # which neither this host nor gamend installs. `Sentry.get_dsn/0` also sees a
  # DSN given only as SENTRY_DSN, which the `:sentry` app env does not.
  defp sentry_info do
    handler? = Enum.any?(:logger.get_handler_config(), &(&1.module == Sentry.LoggerHandler))

    cond do
      Sentry.get_dsn() in [nil, ""] -> "Sentry: disabled (no DSN)"
      handler? -> "Sentry: enabled"
      true -> "Sentry: DSN set, but no Sentry.LoggerHandler installed; nothing is reported"
    end
  end

  defp plugins_info do
    plugins = PluginManager.list()
    count = length(plugins)
    names = Enum.map(plugins, fn p -> p.name end)

    if count == 0 do
      "Plugins: none loaded"
    else
      "Plugins: #{count} loaded (#{Enum.join(names, ", ")})"
    end
  end

  defp channels_info do
    {:ok, modules} = :application.get_key(:gamend_web, :modules)

    channel_mods =
      modules
      |> Enum.filter(fn m ->
        case Atom.to_string(m) do
          "Elixir." <> rest ->
            String.ends_with?(rest, "Channel") and String.starts_with?(rest, "GamendWeb.")

          _ ->
            false
        end
      end)

    "Channels: #{length(channel_mods)} (#{Enum.map_join(channel_mods, ", ", &inspect/1)})"
  end

  defp endpoint_info do
    endpoint_config = Application.get_env(:gamend_web, GamendWeb.Endpoint, [])
    url_config = endpoint_config[:url] || []
    host = url_config[:host] || "localhost"
    port = get_in(endpoint_config, [:http, :port]) || 4000
    "Endpoint: #{host}:#{port}"
  end
end
