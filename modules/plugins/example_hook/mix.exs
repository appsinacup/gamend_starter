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
      env: [hooks_module: Gamend.Modules.ExampleHook]
    ]
  end

  defp deps do
    [
      {:gamend_sdk, github: "appsinacup/gamend", sparse: "sdk", branch: "main", runtime: false},
      {:gamend_plugin_tools,
       github: "appsinacup/gamend", sparse: "sdk_tools", branch: "main", runtime: false}
    ]
  end
end
