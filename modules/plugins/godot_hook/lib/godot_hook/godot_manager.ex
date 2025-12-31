defmodule GodotHook.GodotManager do
  @moduledoc false

  use GenServer
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @doc """
  Best-effort ensure the manager is running.

  If the plugin application is started normally, you don't need this.
  This is mainly a safety net when the hooks module is invoked but the OTP app
  hasn't been started for some reason.
  """
  def ensure_started do
    case Process.whereis(__MODULE__) do
      nil ->
        case start_link([]) do
          {:ok, _pid} -> :ok
          {:error, {:already_started, _pid}} -> :ok
          {:error, reason} -> {:error, reason}
        end

      _pid ->
        :ok
    end
  end

  def notify_async(hook_name, args, meta \\ %{}) when is_atom(hook_name) and is_list(args) do
    Task.start(fn ->
      _ = ensure_started()
      GenServer.cast(__MODULE__, {:notify, hook_name, args, meta})
    end)

    :ok
  end

  @doc "Start the Godot process now (idempotent)."
  def start_godot do
    _ = ensure_started()
    GenServer.call(__MODULE__, :start_godot)
  end

  @doc "Stop the Godot process now (idempotent)."
  def stop_godot do
    _ = ensure_started()
    GenServer.call(__MODULE__, :stop_godot)
  end

  @doc "Stop Godot only if the manager is already running (never starts the manager)."
  def stop_if_running do
    case Process.whereis(__MODULE__) do
      nil ->
        :ok

      _pid ->
        try do
          GenServer.call(__MODULE__, :stop_godot)
        catch
          _, _ -> :ok
        end
    end
  end

  @impl true
  def init(_init_arg) do
    _ = kill_stale_pidfile_process()

    state = %{
      port: nil,
      os_pid: nil,
      last_lines: []
    }

    if config(:autostart) do
      send(self(), :start_godot)
    end

    {:ok, state}
  end

  @impl true
  def handle_info(:start_godot, state) do
    {:noreply, do_start_godot(state)}
  end

  @impl true
  def handle_info({port, {:data, data}}, %{port: port} = state) do
    line = String.trim_trailing(data)

    state =
      state
      |> remember_lines(line)
      |> maybe_log_godot_output(line)

    {:noreply, state}
  end

  @impl true
  def handle_info({port, {:exit_status, status}}, %{port: port} = state) do
    if status == 0 do
      Logger.info("godot exited with status=0")
    else
      last = Enum.reverse(state.last_lines) |> Enum.join("\n")

      Logger.warning(
        "godot exited with status=#{status}" <>
          if(last == "", do: "", else: "\n--- last godot output ---\n" <> last)
      )
    end

    {:noreply, %{state | port: nil, os_pid: nil, last_lines: []}}
  end

  @impl true
  def handle_cast({:notify, hook_name, args, meta}, state) do
    state = if state.port == nil, do: do_start_godot(state), else: state

    payload = %{
      hook: Atom.to_string(hook_name),
      args: Enum.map(args, &json_safe/1),
      meta: json_safe(meta),
      at: DateTime.utc_now() |> DateTime.to_iso8601()
    }

    try do
      GodotHook.WSClient.send_json(payload)
    catch
      kind, reason ->
        Logger.debug("godot_hook notify failed: #{kind}: #{inspect(reason)}")
    end

    {:noreply, state}
  end

  @impl true
  def handle_call(:start_godot, _from, state) do
    {:reply, :ok, do_start_godot(state)}
  end

  @impl true
  def handle_call(:stop_godot, _from, state) do
    {:reply, :ok, do_stop_godot(state)}
  end

  @impl true
  def terminate(_reason, state) do
    _ = do_stop_godot(state)
    :ok
  end

  defp do_start_godot(%{port: port} = state) when is_port(port), do: state

  defp do_start_godot(state) do
    _ = kill_stale_pidfile_process()

    ws_port = ws_port()

    if is_integer(ws_port) and not tcp_port_free?(ws_port) do
      _ = kill_port_owner(ws_port)
    end

    if is_integer(ws_port) and wait_for_tcp_port_free(ws_port, 2_000) == :timeout do
      Logger.error("godot_hook: refusing to start Godot because tcp port #{ws_port} is still in use")
      state
    else
      godot_bin = env_nonempty("GODOT_BIN") || config(:godot_bin)
      project_path = env_nonempty("GODOT_PROJECT_PATH") || config(:godot_project_path)
      cond do
        not is_binary(godot_bin) or godot_bin == "" ->
          Logger.warning("godot_hook: GODOT_BIN not set; cannot start Godot")
          state

        not is_binary(project_path) or project_path == "" ->
          Logger.warning("godot_hook: GODOT_PROJECT_PATH not set; cannot start Godot")
          state

        true ->
          args =
            ["--headless", "--path", project_path] ++
              config(:godot_args) ++
              (env_nonempty("GODOT_ARGS") |> parse_args_env())

          port =
            Port.open({:spawn_executable, godot_bin}, [
              :binary,
              :use_stdio,
              :exit_status,
              :stderr_to_stdout,
              args: args
            ])

          os_pid =
            case Port.info(port, :os_pid) do
              {:os_pid, pid} -> pid
              _ -> nil
            end

          _ = write_pidfile(os_pid)

          Logger.info("godot_hook: started Godot (os_pid=#{inspect(os_pid)})")
          _ = send_after_startup()
          %{state | port: port, os_pid: os_pid, last_lines: []}
      end
    end
  end

  defp do_stop_godot(%{port: nil} = state), do: state

  defp do_stop_godot(%{port: port, os_pid: os_pid} = state) do
    if is_integer(os_pid) do
      _ = kill_pid(os_pid)
    end

    ws_port = ws_port()

    if is_integer(ws_port) do
      if not tcp_port_free?(ws_port) do
        _ = kill_port_owner(ws_port)
      end

      _ = wait_for_tcp_port_free(ws_port, 2_000)
    end

    try do
      Port.close(port)
    catch
      _, _ -> :ok
    end

    if is_integer(os_pid) and process_alive?(os_pid) do
      Logger.warning(
        "godot_hook: Godot pid still alive after stop attempt (pid=#{os_pid}); leaving pidfile for next start"
      )
    else
      _ = remove_pidfile()
    end
    %{state | port: nil, os_pid: nil}
  end

  defp config(key) do
    Application.get_env(:godot_hook, key)
  end

  defp parse_args_env(nil), do: []
  defp parse_args_env(""), do: []

  defp parse_args_env(str) when is_binary(str) do
    str
    |> String.split(" ", trim: true)
    |> Enum.reject(&(&1 == ""))
  end

  defp env_nonempty(key) when is_binary(key) do
    case System.get_env(key) do
      nil -> nil
      "" -> nil
      val -> val
    end
  end

  defp pidfile_path do
    env_nonempty("GODOT_PIDFILE") ||
      Application.get_env(:godot_hook, :godot_pidfile, "/tmp/godot_hook.pid")
  end

  defp kill_stale_pidfile_process do
    path = pidfile_path()

    cond do
      not is_binary(path) or path == "" ->
        :ok

      true ->
        case File.read(path) do
          {:ok, content} ->
            pid = decode_pidfile(content)

            cond do
              is_integer(pid) and pid > 0 and process_alive?(pid) ->
                Logger.warning(
                  "godot_hook: killing stale Godot process from pidfile #{path} (pid=#{pid})"
                )

                _ = kill_pid(pid)

                if process_alive?(pid) do
                  Logger.error(
                    "godot_hook: failed to kill stale Godot process (pid=#{pid}); leaving pidfile #{path}"
                  )
                else
                  Logger.info("godot_hook: killed stale Godot process (pid=#{pid})")
                  _ = remove_pidfile()
                end

                :ok

              is_integer(pid) and pid > 0 and not process_alive?(pid) ->
                Logger.info(
                  "godot_hook: pidfile #{path} points to non-running pid=#{pid}; removing pidfile"
                )

                _ = remove_pidfile()
                :ok

              true ->
                Logger.warning(
                  "godot_hook: pidfile #{path} contents are invalid; removing pidfile"
                )

                _ = remove_pidfile()
                :ok
            end

          {:error, :enoent} ->
            :ok

          {:error, reason} ->
            Logger.debug("godot_hook: could not read pidfile #{path}: #{inspect(reason)}")
            :ok
        end
    end
  end

  defp process_alive?(pid) when is_integer(pid) do
    # In our Docker image `kill` is a shell builtin (no /bin/kill), so the most
    # reliable check is procfs.
    File.dir?("/proc/#{pid}")
  rescue
    _ -> false
  end

  defp kill_pid(pid) when is_integer(pid) do
    Logger.info("godot_hook: sending TERM to pid=#{pid}")
    _ = run_kill(["-TERM", Integer.to_string(pid)], "pid=#{pid}")
    Process.sleep(250)

    alive_after_term = process_alive?(pid)
    Logger.debug("godot_hook: pid=#{pid} alive_after_TERM=#{alive_after_term}")

    if alive_after_term do
      Logger.info("godot_hook: sending KILL to pid=#{pid}")
      _ = run_kill(["-KILL", Integer.to_string(pid)], "pid=#{pid}")
    end

    # Give the OS a moment to reap.
    Process.sleep(50)

    alive_after_kill = process_alive?(pid)
    Logger.debug("godot_hook: pid=#{pid} alive_after_KILL=#{alive_after_kill}")
    :ok
  rescue
    _ -> :ok
  end

  defp ws_port do
    url = env_nonempty("GODOT_WS_URL") || config(:godot_ws_url)
    ws_port_from_url(url)
  end

  defp ws_port_from_url(nil), do: nil
  defp ws_port_from_url(""), do: nil

  defp ws_port_from_url(url) when is_binary(url) do
    case URI.parse(url) do
      %URI{port: port} when is_integer(port) -> port
      _ -> nil
    end
  rescue
    _ -> nil
  end

  defp wait_for_tcp_port_free(port, timeout_ms)
       when is_integer(port) and port > 0 and is_integer(timeout_ms) and timeout_ms >= 0 do
    started = System.monotonic_time(:millisecond)

    if tcp_port_free?(port) do
      Logger.info("godot_hook: tcp port #{port} is free")
      :ok
    else
      Logger.warning("godot_hook: tcp port #{port} is in use; waiting up to #{timeout_ms}ms")
      do_wait_for_tcp_port_free(port, timeout_ms, started)
    end
  end

  defp do_wait_for_tcp_port_free(port, timeout_ms, started_ms) do
    if tcp_port_free?(port) do
      Logger.info("godot_hook: tcp port #{port} became free")
      :ok
    else
      now = System.monotonic_time(:millisecond)

      if now - started_ms >= timeout_ms do
        Logger.error("godot_hook: tcp port #{port} still in use after #{timeout_ms}ms")
        :timeout
      else
        Process.sleep(100)
        do_wait_for_tcp_port_free(port, timeout_ms, started_ms)
      end
    end
  end

  defp tcp_port_free?(port) when is_integer(port) do
    case :gen_tcp.listen(port, [:binary, active: false, reuseaddr: true]) do
      {:ok, socket} ->
        :ok = :gen_tcp.close(socket)
        true

      {:error, :eaddrinuse} ->
        false

      {:error, _other} ->
        # If we can't reliably determine, don't block startup.
        true
    end
  end

  defp kill_port_owner(port) when is_integer(port) and port > 0 do
    pids = port_owner_pids(port)

    if pids == [] do
      Logger.warning("godot_hook: tcp port #{port} in use but no owner pid found")
      :ok
    else
      Enum.each(pids, fn pid ->
        Logger.warning("godot_hook: killing tcp port #{port} owner pid=#{pid}")
        _ = kill_pid(pid)

        # If it didn't die, try a second hard kill.
        if process_alive?(pid) do
          Logger.warning("godot_hook: pid=#{pid} still alive after kill; retrying KILL")
          _ = run_kill(["-KILL", Integer.to_string(pid)], "pid=#{pid} retry")
        end
      end)

      still = port_owner_pids(port)

      if still != [] do
        Logger.error(
          "godot_hook: tcp port #{port} still owned by pids=#{inspect(still, charlists: :as_lists)}"
        )
      else
        Logger.info("godot_hook: tcp port #{port} has no remaining owners")
      end

      :ok
    end
  end

  defp run_kill(args, label) do
    # In our Docker image, `kill` is typically a shell builtin (no /bin/kill).
    # So always run it via `sh -lc`.
    cmd = "kill " <> Enum.join(args, " ")

    case System.cmd("sh", ["-lc", cmd], stderr_to_stdout: true) do
      {out, 0} ->
        {{out, 0}, 0}

      {out, status} ->
        Logger.warning("godot_hook: kill #{label} failed status=#{status} out=#{String.trim(out)}")
        {{out, status}, status}
    end
  rescue
    e ->
      Logger.warning("godot_hook: kill #{label} raised: #{inspect(e)}")
      {{"", 1}, 1}
  end

  defp port_owner_pids(port) when is_integer(port) and port > 0 do
    if File.exists?("/proc/net/tcp") or File.exists?("/proc/net/tcp6") do
      procfs_pids(port) |> Enum.uniq()
    else
      []
    end
  end

  defp procfs_pids(port) when is_integer(port) and port > 0 do
    inodes =
      (tcp_listen_inodes("/proc/net/tcp", port) ++ tcp_listen_inodes("/proc/net/tcp6", port))
      |> Enum.uniq()

    if inodes == [] do
      []
    else
      pids_by_inodes(inodes)
    end
  end

  defp tcp_listen_inodes(path, port) when is_binary(path) and is_integer(port) do
    if File.exists?(path) do
      case File.read(path) do
        {:ok, content} ->
          content
          |> String.split("\n", trim: true)
          |> Enum.drop(1)
          |> Enum.flat_map(fn line ->
            fields = String.split(String.trim(line), ~r/\s+/, trim: true)

            # fields: [sl, local_address, rem_address, st, ..., inode, ...]
            local = Enum.at(fields, 1)
            st = Enum.at(fields, 3)
            inode = Enum.at(fields, 9)

            cond do
              is_nil(local) or is_nil(st) or is_nil(inode) ->
                []

              st != "0A" ->
                # LISTEN only
                []

              true ->
                case String.split(local, ":", parts: 2) do
                  [_ip_hex, port_hex] ->
                    case Integer.parse(port_hex, 16) do
                      {p, _} when p == port -> [inode]
                      _ -> []
                    end

                  _ ->
                    []
                end
            end
          end)

        _ ->
          []
      end
    else
      []
    end
  rescue
    _ -> []
  end

  defp pids_by_inodes(inodes) when is_list(inodes) do
    inode_set = MapSet.new(inodes)

    "/proc"
    |> File.ls!()
    |> Enum.filter(&String.match?(&1, ~r/^\d+$/))
    |> Enum.flat_map(fn pid_str ->
      pid = String.to_integer(pid_str)
      fds_dir = "/proc/#{pid_str}/fd"

      if File.dir?(fds_dir) do
        case File.ls(fds_dir) do
          {:ok, fds} ->
            Enum.any?(fds, fn fd ->
              link_path = Path.join(fds_dir, fd)

              case File.read_link(link_path) do
                {:ok, "socket:[" <> rest} ->
                  inode = String.trim_trailing(rest, "]")
                  MapSet.member?(inode_set, inode)

                _ ->
                  false
              end
            end)
            |> case do
              true -> [pid]
              false -> []
            end

          _ ->
            []
        end
      else
        []
      end
    end)
  rescue
    _ -> []
  end

  defp write_pidfile(nil), do: :ok

  defp write_pidfile(pid) when is_integer(pid) do
    path = pidfile_path()

    with true <- is_binary(path),
         true <- path != "" do
      _ = File.write(path, Integer.to_string(pid))
      Logger.info("godot_hook: wrote pidfile #{path} (pid=#{pid})")
      :ok
    else
      _ -> :ok
    end
  end

  defp decode_pidfile(content) when is_binary(content) do
    content = String.trim(content)

    case Integer.parse(content) do
      {pid, _} when pid > 0 -> pid
      _ ->
        case Jason.decode(content) do
          {:ok, %{"pid" => pid}} when is_integer(pid) and pid > 0 -> pid
          _ -> nil
        end
    end
  rescue
    _ -> nil
  end

  defp remove_pidfile do
    path = pidfile_path()

    if is_binary(path) and path != "" do
      _ = File.rm(path)
      Logger.debug("godot_hook: removed pidfile #{path}")
    end

    :ok
  end

  defp remember_lines(%{last_lines: last_lines} = state, data) when is_binary(data) do
    # Port may deliver multiple lines; keep a short tail buffer.
    new_lines =
      data
      |> String.split("\n", trim: true)
      |> Enum.map(&String.trim_trailing/1)

    last_lines =
      (Enum.reverse(new_lines) ++ last_lines)
      |> Enum.take(40)

    %{state | last_lines: last_lines}
  end

  defp maybe_log_godot_output(state, data) do
    level = config(:godot_output_log_level) || :info

    data
    |> String.split("\n", trim: true)
    |> Enum.each(fn line ->
      Logger.log(level, "godot: #{line}")
    end)

    state
  end

  defp json_safe(term), do: json_safe(term, 0)

  defp json_safe(_term, depth) when depth >= 4, do: "[truncated]"

  defp json_safe(nil, _depth), do: nil
  defp json_safe(true, _depth), do: true
  defp json_safe(false, _depth), do: false
  defp json_safe(n, _depth) when is_integer(n) or is_float(n), do: n
  defp json_safe(bin, _depth) when is_binary(bin), do: bin
  defp json_safe(atom, _depth) when is_atom(atom), do: Atom.to_string(atom)

  defp json_safe(%DateTime{} = dt, _depth), do: DateTime.to_iso8601(dt)
  defp json_safe(%NaiveDateTime{} = dt, _depth), do: NaiveDateTime.to_iso8601(dt)
  defp json_safe(%Date{} = d, _depth), do: Date.to_iso8601(d)
  defp json_safe(%Time{} = t, _depth), do: Time.to_iso8601(t)

  defp json_safe(%URI{} = uri, _depth), do: URI.to_string(uri)

  defp json_safe(%_{} = struct, depth) do
    struct_module = struct.__struct__

    struct_module_name = Atom.to_string(struct_module)

    # Keep Godot payloads small and stable for common schemas.
    cond do
      struct_module_name == "Elixir.GameServer.Accounts.User" ->
        user_fields(struct)

      true ->
        if struct_module_name in ["Elixir.Ecto.Association.NotLoaded", "Elixir.Ecto.Schema.Metadata"] do
          nil
        else
          # If the struct has a stable string representation (e.g., Decimal), prefer that.
          case String.Chars.impl_for(struct) do
            nil ->
              struct
              |> Map.from_struct()
              |> Map.drop([:__meta__])
              |> Enum.reduce(%{}, fn {k, v}, acc ->
                key = if is_atom(k), do: Atom.to_string(k), else: to_string(k)

                cond do
                  String.starts_with?(key, "__") ->
                    acc

                  true ->
                    Map.put(acc, key, json_safe(v, depth + 1))
                end
              end)

            _impl ->
              to_string(struct)
          end
        end
    end
  end

  defp json_safe(map, depth) when is_map(map) do
    map
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      key = if is_atom(k), do: Atom.to_string(k), else: to_string(k)
      Map.put(acc, key, json_safe(v, depth + 1))
    end)
  end

  defp json_safe(list, depth) when is_list(list) do
    Enum.map(list, &json_safe(&1, depth + 1))
  end

  defp json_safe(tuple, depth) when is_tuple(tuple) do
    tuple
    |> Tuple.to_list()
    |> json_safe(depth)
  end

  defp json_safe(other, _depth) do
    inspect(other, printable_limit: 5_000, limit: 50)
  end

  defp send_after_startup do
    GodotHook.WSClient.send_json(%{
      hook: "after_startup",
      args: [],
      meta: %{},
      at: DateTime.utc_now() |> DateTime.to_iso8601()
    })
  end

  defp user_fields(user_struct) do
    base =
      user_struct
      |> Map.from_struct()
      |> Map.take([
        :id,
        :email,
        :display_name,
        :is_admin,
        :profile_url,
        :confirmed_at,
        :authenticated_at,
        :discord_id,
        :steam_id,
        :google_id,
        :facebook_id,
        :apple_id,
        :device_id,
        :lobby_id,
        :inserted_at,
        :updated_at
      ])

    json_safe(base)
  rescue
    _ -> %{}
  end
end
