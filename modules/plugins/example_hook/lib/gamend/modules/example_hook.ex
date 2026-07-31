defmodule Gamend.Modules.ExampleHook do
  @moduledoc """
  A second example plugin.

  It exists to demonstrate that multiple hook plugins load and run side by side
  with `starter_hook` — the server discovers every subdirectory of
  `GAMEND_CONTENT_PLUGINS_DIR` that has a `mix.exs`, and fans lifecycle hooks out to
  all of them.
  """

  use Gamend.Hooks

  require Logger

  @impl true
  def after_user_logged_in(user) do
    Logger.info("example_hook: user #{user.id} logged in")
    :ok
  end

  @doc ~s|Returns "pong". Call from a client as `example_hook.ping()`.|
  def ping, do: "pong"
end
