defmodule GodotHook.WSConn do
  @moduledoc false

  use WebSockex

  require Logger

  @impl true
  def handle_connect(_conn, state) do
    Logger.info("godot_ws: connected")

    if is_map(state) and is_pid(Map.get(state, :parent)) do
      send(state.parent, {:ws_connected, self()})
    end

    {:ok, state}
  end

  @impl true
  def handle_disconnect(%{reason: reason}, state) do
    Logger.warning("godot_ws: disconnected: #{inspect(reason)}")
    {:reconnect, state}
  end

  @impl true
  def handle_frame({:text, msg}, state) do
    Logger.debug("godot_ws: recv text: #{msg}")
    {:ok, state}
  end

  def handle_frame(_frame, state), do: {:ok, state}

  @impl true
  def handle_cast({:send, frame}, state) do
    {:reply, frame, state}
  end
end
