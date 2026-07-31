defmodule StarterHook.MixProject do
  use Mix.Project

  def project do
    [
      app: :starter_hook,
      version: "0.1.1",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      env: [hooks_module: Gamend.Modules.StarterHook]
    ]
  end

  defp deps do
    [
      {:gamend_sdk, github: "appsinacup/gamend", sparse: "sdk", runtime: false},
      {:gamend_plugin_tools, github: "appsinacup/gamend", sparse: "sdk_tools", runtime: false},
      # Typed hook payloads (see proto/starter_hook.proto).
      {:protobuf, "~> 0.17"}
    ]
  end
end
