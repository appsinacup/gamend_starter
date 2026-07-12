defmodule ExampleHook.MixProject do
  use Mix.Project

  def project do
    [
      app: :example_hook,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      env: [hooks_module: GameServer.Modules.ExampleHook]
    ]
  end

  defp deps do
    [
      {:game_server_sdk, github: "appsinacup/game_server", sparse: "sdk", runtime: false},
      {:game_server_plugin_tools,
       github: "appsinacup/game_server", sparse: "sdk_tools", runtime: false}
    ]
  end
end
