defmodule GodotHook.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GodotHook.GodotManager,
      {GodotHook.WSClient, [url: ws_url()]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: GodotHook.Supervisor)
  end

  @impl true
  def stop(_state) do
    _ = GodotHook.GodotManager.stop_if_running()
    :ok
  end

  defp ws_url do
    env_nonempty("GODOT_WS_URL") ||
      Application.get_env(:godot_hook, :godot_ws_url, "ws://127.0.0.1:4010")
  end

  defp env_nonempty(key) when is_binary(key) do
    case System.get_env(key) do
      nil -> nil
      "" -> nil
      val -> val
    end
  end
end
