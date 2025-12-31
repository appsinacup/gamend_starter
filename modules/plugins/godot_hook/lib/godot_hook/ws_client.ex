defmodule GodotHook.WSClient do
  @moduledoc false

  use GenServer

  require Logger

  def start_link(opts) do
    url = Keyword.fetch!(opts, :url)
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, %{url: url}, name: name)
  end

  def send_json(server \\ __MODULE__, map) when is_map(map) do
    GenServer.cast(server, {:send_json, map})
  end

  def rpc(server \\ __MODULE__, map, timeout_ms \\ 2_000)
      when is_map(map) and is_integer(timeout_ms) and timeout_ms > 0 do
    GenServer.call(server, {:rpc, map, timeout_ms}, timeout_ms + 500)
  end

  def await_connected(server \\ __MODULE__, timeout_ms \\ 5_000)
      when is_integer(timeout_ms) and timeout_ms > 0 do
    GenServer.call(server, {:await_connected, timeout_ms}, timeout_ms + 500)
  end

  @impl true
  def init(%{url: url}) do
    state = %{
      url: url,
      conn_pid: nil,
      conn_ref: nil,
      retry_ms: 200,
      outbox: :queue.new(),
      pending: %{},
      connected?: false,
      connected_waiters: %{},
      connected_waiter_seq: 0
    }

    send(self(), :connect)
    {:ok, state}
  end

  @impl true
  def handle_info(:connect, state) do
    case WebSockex.start_link(state.url, GodotHook.WSConn, %{parent: self()}) do
      {:ok, pid} ->
        ref = Process.monitor(pid)
        {:noreply, %{state | conn_pid: pid, conn_ref: ref, retry_ms: 200}}

      {:error, %WebSockex.ConnError{} = err} ->
        Logger.info("godot_ws: connect failed (will retry): #{inspect(err.original)}")
        schedule_reconnect(state)

      {:error, reason} ->
        Logger.info("godot_ws: connect failed (will retry): #{inspect(reason)}")
        schedule_reconnect(state)
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, pid, reason}, %{conn_ref: ref, conn_pid: pid} = state) do
    Logger.info("godot_ws: connection exited (will retry): #{inspect(reason)}")

    state
    |> Map.merge(%{conn_pid: nil, conn_ref: nil})
    |> Map.put(:connected?, false)
    |> schedule_reconnect()
  end

  @impl true
  def handle_info({:ws_connected, pid}, %{conn_pid: pid} = state) do
    state = %{state | connected?: true}
    state = flush_outbox(state)
    state = reply_connected_waiters(state)
    {:noreply, state}
  end

  @impl true
  def handle_info({:ws_text, msg}, state) when is_binary(msg) do
    state = maybe_fulfill_rpc(state, msg)
    {:noreply, state}
  end

  @impl true
  def handle_info({:rpc_timeout, request_id}, state) when is_binary(request_id) do
    case Map.pop(state.pending, request_id) do
      {nil, _pending} ->
        {:noreply, state}

      {%{from: from}, pending} ->
        Logger.warning("godot_ws: rpc timeout request_id=#{request_id}")
        GenServer.reply(from, {:error, :timeout})
        {:noreply, %{state | pending: pending}}
    end
  end

  @impl true
  def handle_info({:await_connected_timeout, waiter_id}, state) when is_integer(waiter_id) do
    case Map.pop(state.connected_waiters, waiter_id) do
      {nil, _waiters} ->
        {:noreply, state}

      {from, waiters} ->
        Logger.warning("godot_ws: await_connected timeout")
        GenServer.reply(from, {:error, :timeout})
        {:noreply, %{state | connected_waiters: waiters}}
    end
  end

  @impl true
  def handle_info(_msg, state), do: {:noreply, state}

  @impl true
  def handle_call({:rpc, map, timeout_ms}, from, state) do
    if is_pid(state.conn_pid) and Process.alive?(state.conn_pid) do
      request_id = unique_request_id()
      payload = Map.put(map, :request_id, request_id)

      hook = Map.get(map, :hook) || Map.get(map, "hook")
      Logger.debug("godot_ws: rpc send hook=#{inspect(hook)} request_id=#{request_id} timeout_ms=#{timeout_ms}")

      frame = {:text, Jason.encode!(payload)}
      Logger.debug("godot_ws: rpc frame request_id=#{request_id} #{elem(frame, 1)}")
      _ = WebSockex.cast(state.conn_pid, {:send, frame})

      Process.send_after(self(), {:rpc_timeout, request_id}, timeout_ms)

      pending = Map.put(state.pending, request_id, %{from: from})
      {:noreply, %{state | pending: pending}}
    else
      {:reply, {:error, :not_connected}, state}
    end
  end

  @impl true
  def handle_call({:await_connected, _timeout_ms}, _from, %{connected?: true} = state) do
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:await_connected, timeout_ms}, from, state) do
    waiter_id = state.connected_waiter_seq + 1
    Process.send_after(self(), {:await_connected_timeout, waiter_id}, timeout_ms)

    waiters = Map.put(state.connected_waiters, waiter_id, from)
    {:noreply, %{state | connected_waiters: waiters, connected_waiter_seq: waiter_id}}
  end

  @impl true
  def handle_cast({:send_json, map}, state) do
    if is_pid(state.conn_pid) and Process.alive?(state.conn_pid) do
      frame = {:text, Jason.encode!(map)}
      _ = WebSockex.cast(state.conn_pid, {:send, frame})
      {:noreply, state}
    else
      {:noreply, enqueue_outbox(state, map)}
    end
  end

  defp schedule_reconnect(state) do
    Process.send_after(self(), :connect, state.retry_ms)
    {:noreply, %{state | retry_ms: min(state.retry_ms * 2, 5_000)}}
  end

  defp enqueue_outbox(%{outbox: outbox} = state, map) when is_map(map) do
    outbox = :queue.in(map, outbox)

    # Keep this bounded to avoid unbounded memory growth.
    outbox = trim_outbox(outbox, 200)
    %{state | outbox: outbox}
  end

  defp trim_outbox(outbox, max) when is_integer(max) and max > 0 do
    if :queue.len(outbox) > max do
      {_dropped, outbox} = :queue.out(outbox)
      trim_outbox(outbox, max)
    else
      outbox
    end
  end

  defp flush_outbox(%{outbox: outbox} = state) do
    if not (is_pid(state.conn_pid) and Process.alive?(state.conn_pid)) do
      state
    else
      do_flush_outbox(%{state | outbox: outbox})
    end
  end

  defp do_flush_outbox(%{outbox: outbox} = state) do
    case :queue.out(outbox) do
      {{:value, map}, rest} ->
        frame = {:text, Jason.encode!(map)}
        _ = WebSockex.cast(state.conn_pid, {:send, frame})
        do_flush_outbox(%{state | outbox: rest})

      {:empty, _} ->
        state
    end
  end

  defp reply_connected_waiters(%{connected_waiters: waiters} = state) do
    Enum.each(waiters, fn {_id, from} ->
      GenServer.reply(from, :ok)
    end)

    %{state | connected_waiters: %{}}
  end

  defp maybe_fulfill_rpc(state, msg) do
    with {:ok, decoded} <- Jason.decode(msg),
         request_id when is_binary(request_id) <- Map.get(decoded, "request_id"),
         true <- Map.has_key?(state.pending, request_id) do
      {entry, pending} = Map.pop(state.pending, request_id)
      from = entry.from

      Logger.debug(
        "godot_ws: rpc recv request_id=#{request_id} ok=#{inspect(Map.get(decoded, "ok"))}"
      )

      reply =
        cond do
          Map.get(decoded, "ok") == true -> {:ok, Map.get(decoded, "result")}
          Map.get(decoded, "ok") == false -> {:error, Map.get(decoded, "error") || :error}
          Map.has_key?(decoded, "result") -> {:ok, Map.get(decoded, "result")}
          Map.has_key?(decoded, "error") -> {:error, Map.get(decoded, "error")}
          true -> {:ok, decoded}
        end

      GenServer.reply(from, reply)
      %{state | pending: pending}
    else
      _ ->
        state
    end
  end

  defp unique_request_id do
    :erlang.unique_integer([:positive, :monotonic])
    |> Integer.to_string()
  end
end
