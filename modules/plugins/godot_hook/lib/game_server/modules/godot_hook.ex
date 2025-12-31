defmodule GameServer.Modules.GodotHook do
  @moduledoc """
  Hook module that forwards lifecycle callbacks to a local Godot instance.

  Godot is started by the plugin OTP application (`GodotHook.Application`).

  Payloads are sent as JSON WebSocket text frames to `GODOT_WS_URL` (default:
  `ws://127.0.0.1:4010`).
  """

  use GameServer.Hooks

  @impl true
  def after_user_register(user) do
    GodotHook.GodotManager.notify_async(:after_user_register, [user], caller_meta())
    :ok
  end

  @impl true
  def after_user_login(user) do
    GodotHook.GodotManager.notify_async(:after_user_login, [user], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_create(attrs) do
    GodotHook.GodotManager.notify_async(:before_lobby_create, [attrs], caller_meta())
    {:ok, attrs}
  end

  @impl true
  def after_lobby_create(lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_create, [lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_join(user, lobby, opts) do
    GodotHook.GodotManager.notify_async(:before_lobby_join, [user, lobby, opts], caller_meta())
    {:ok, {user, lobby, opts}}
  end

  @impl true
  def after_lobby_join(user, lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_join, [user, lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_leave(user, lobby) do
    GodotHook.GodotManager.notify_async(:before_lobby_leave, [user, lobby], caller_meta())
    {:ok, {user, lobby}}
  end

  @impl true
  def after_lobby_leave(user, lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_leave, [user, lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_update(lobby, attrs) do
    GodotHook.GodotManager.notify_async(:before_lobby_update, [lobby, attrs], caller_meta())
    {:ok, attrs}
  end

  @impl true
  def after_lobby_update(lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_update, [lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_delete(lobby) do
    GodotHook.GodotManager.notify_async(:before_lobby_delete, [lobby], caller_meta())
    {:ok, lobby}
  end

  @impl true
  def after_lobby_delete(lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_delete, [lobby], caller_meta())
    :ok
  end

  @impl true
  def before_user_kicked(host, target, lobby) do
    GodotHook.GodotManager.notify_async(:before_user_kicked, [host, target, lobby], caller_meta())
    {:ok, {host, target, lobby}}
  end

  @impl true
  def after_user_kicked(host, target, lobby) do
    GodotHook.GodotManager.notify_async(:after_user_kicked, [host, target, lobby], caller_meta())
    :ok
  end

  @impl true
  def after_lobby_host_change(lobby, new_host_id) do
    GodotHook.GodotManager.notify_async(:after_lobby_host_change, [lobby, new_host_id], caller_meta())
    :ok
  end

  def get_status do
    GodotHook.GodotManager.notify_async(:get_status, [], caller_meta())
    :ok
  end

  defp caller_meta do
    caller = Process.get(:game_server_hook_caller)

    %{
      caller: caller
    }
  end
end
