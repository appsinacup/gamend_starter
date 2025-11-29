defmodule GameServer.Modules.StarterHook do
  @moduledoc """

  Starter hook.
  """

  @behaviour GameServer.Hooks

  alias GameServer.Repo

  @impl true
  def after_user_register(user) do
    :ok
  end

  @impl true
  def after_user_login(user) do
    :ok
  end

  @impl true
  def before_lobby_create(attrs), do: {:ok, attrs}

  @impl true
  def after_lobby_create(_lobby), do: :ok

  @impl true
  def before_lobby_join(_user, _lobby, _opts), do: {:ok, :noop}

  @impl true
  def after_lobby_join(_user, _lobby), do: :ok

  @impl true
  def before_lobby_leave(_user, _lobby), do: {:ok, :noop}

  @impl true
  def after_lobby_leave(_user, _lobby), do: :ok

  @impl true
  def before_lobby_update(_lobby, attrs), do: {:ok, attrs}

  @impl true
  def after_lobby_update(_lobby), do: :ok

  @impl true
  def before_lobby_delete(_lobby), do: {:ok, :noop}

  @impl true
  def after_lobby_delete(_lobby), do: :ok

  @impl true
  def before_user_kicked(_host, _target, _lobby), do: {:ok, :noop}

  @impl true
  def after_user_kicked(_host, _target, _lobby), do: :ok

  @impl true
  def after_lobby_host_change(_lobby, _new_host_id), do: :ok
end
