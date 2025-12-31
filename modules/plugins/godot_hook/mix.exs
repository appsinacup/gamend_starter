defmodule GodotHook.MixProject do
  use Mix.Project

  def project do
    [
      app: :godot_hook,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {GodotHook.Application, []},
      extra_applications: [:logger, :inets, :ssl],
      env: [
        hooks_module: GameServer.Modules.GodotHook,
        autostart: true,
        godot_bin: "/opt/godot/godot",
        godot_project_path: "/app/godot",
        godot_args: [],
        godot_ws_url: "ws://127.0.0.1:4010",
        godot_output_log_level: :info,
        startup_timeout_ms: 10_000,
        request_timeout_ms: 2_000
      ]
    ]
  end

  defp deps do
    [
      {:game_server_sdk, github: "appsinacup/game_server", sparse: "sdk", runtime: false},
      {:game_server_plugin_tools, github: "appsinacup/game_server", sparse: "sdk_tools", runtime: false},
      {:jason, "~> 1.4"},
      {:websockex, "~> 0.4.3"}
    ]
  end
end
