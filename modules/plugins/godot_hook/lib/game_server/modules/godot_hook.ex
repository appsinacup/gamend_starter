defmodule GameServer.Modules.GodotHook do
  @moduledoc """
  Hook module that forwards lifecycle callbacks to a local Godot instance.

  Godot is started by the plugin OTP application (`GodotHook.Application`).

  Payloads are sent as JSON WebSocket text frames to `GODOT_WS_URL` (default:
  `ws://127.0.0.1:4010`).
  """

  @behaviour GameServer.Hooks

  @timeout_ms 5_000
  @startup_timeout_ms 10_000

  @impl true
  def after_startup do
    GodotHook.GodotManager.call(:after_startup, [], caller_meta(), @startup_timeout_ms)
  end

  @impl true
  def before_stop do
    GodotHook.GodotManager.notify_async(:before_stop, [], caller_meta())
    :ok
  end

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
    case GodotHook.GodotManager.call(:before_lobby_create, [attrs], caller_meta(), @timeout_ms) do
      {:error, reason} ->
        {:error, reason}

      {:ok, new_attrs} when is_map(new_attrs) ->
        {:ok, new_attrs}

      _ ->
        {:ok, attrs}
    end
  end

  @impl true
  def after_lobby_create(lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_create, [lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_join(user, lobby, opts) do
    case GodotHook.GodotManager.call(:before_lobby_join, [user, lobby, opts], caller_meta(), @timeout_ms) do
      {:error, reason} -> {:error, reason}
      _ -> {:ok, {user, lobby, opts}}
    end
  end

  @impl true
  def after_lobby_join(user, lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_join, [user, lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_leave(user, lobby) do
    case GodotHook.GodotManager.call(:before_lobby_leave, [user, lobby], caller_meta(), @timeout_ms) do
      {:error, reason} -> {:error, reason}
      _ -> {:ok, {user, lobby}}
    end
  end

  @impl true
  def after_lobby_leave(user, lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_leave, [user, lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_update(lobby, attrs) do
    case GodotHook.GodotManager.call(:before_lobby_update, [lobby, attrs], caller_meta(), @timeout_ms) do
      {:error, reason} ->
        {:error, reason}

      {:ok, new_attrs} when is_map(new_attrs) ->
        {:ok, new_attrs}

      _ ->
        {:ok, attrs}
    end
  end

  @impl true
  def after_lobby_update(lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_update, [lobby], caller_meta())
    :ok
  end

  @impl true
  def before_lobby_delete(lobby) do
    case GodotHook.GodotManager.call(:before_lobby_delete, [lobby], caller_meta(), @timeout_ms) do
      {:error, reason} -> {:error, reason}
      _ -> {:ok, lobby}
    end
  end

  @impl true
  def after_lobby_delete(lobby) do
    GodotHook.GodotManager.notify_async(:after_lobby_delete, [lobby], caller_meta())
    :ok
  end

  @impl true
  def before_user_kicked(host, target, lobby) do
    case GodotHook.GodotManager.call(:before_user_kicked, [host, target, lobby], caller_meta(), @timeout_ms) do
      {:error, reason} -> {:error, reason}
      _ -> {:ok, {host, target, lobby}}
    end
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

  @impl true
  def before_kv_get(key, opts) do
    case GodotHook.GodotManager.call(:before_kv_get, [key, opts], caller_meta(), @timeout_ms) do
      {:ok, scope} when scope in [:public, :private] ->
        {:ok, scope}

      scope when scope in [:public, :private] ->
        scope

      {:error, reason} ->
        {:error, reason}

      _ ->
        :public
    end
  end

  def get_status do
    GodotHook.GodotManager.call(:get_status, [], caller_meta())
  end

  def on_custom_hook(name, args, _opts) do
    GodotHook.GodotManager.call(:on_custom_hook, [name, args], caller_meta(), @timeout_ms)
  end

  defp caller_meta do
    caller = Process.get(:game_server_hook_caller)

    %{
      caller: caller
    }
  end
end
