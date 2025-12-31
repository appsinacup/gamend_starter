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

  @impl true
  def init(%{url: url}) do
    state = %{
      url: url,
      conn_pid: nil,
      conn_ref: nil,
      retry_ms: 200,
      outbox: :queue.new()
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
    |> schedule_reconnect()
  end

  @impl true
  def handle_info({:ws_connected, pid}, %{conn_pid: pid} = state) do
    state = flush_outbox(state)
    {:noreply, state}
  end

  @impl true
  def handle_info(_msg, state), do: {:noreply, state}

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
end
