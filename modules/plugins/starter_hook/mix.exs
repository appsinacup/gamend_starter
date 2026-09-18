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
      {:gamend_sdk, "~> 1.0", runtime: false},
      {:gamend_plugin_tools, "~> 1.0", runtime: false},
      # Typed hook payloads (see proto/starter_hook.proto).
      {:protobuf, "~> 0.17"}
    ]
  end
end
