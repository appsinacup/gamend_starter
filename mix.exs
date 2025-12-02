defmodule GamendStarter.MixProject do
  use Mix.Project

  def project do
    [
      app: :gamend_starter,
      version: "0.1.0",
      elixir: "~> 1.17",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:game_server_sdk, github: "appsinacup/game_server", sparse: "sdk"}
    ]
  end
end
