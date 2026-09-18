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
      {:gamend_sdk, "~> 1.0", runtime: false},
      {:gamend_plugin_tools, "~> 1.0", runtime: false}
    ]
  end
end
