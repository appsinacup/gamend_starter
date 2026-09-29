# Rename this module to match your project, e.g. MyGame.MixProject
# Also update: app: :my_game, name: "MyGame"
# and the Application module reference in application/0 below, and every
# :gamend_host in config/ (config.exs, prod.exs).
defmodule GamendHost.MixProject do
  use Mix.Project

  # The engine checkout, when one sits beside this app. Anchored to __DIR__
  # rather than the cwd: `apps/gamend_web` was looked for relative to *this*
  # project, which is not an umbrella and so never has it, and local mode could
  # not be reached even with the sibling right there.
  @local_gamend_root Path.expand("../gamend", __DIR__)

  def project do
    [
      app: :gamend_host,
      name: "Gamend",
      version: System.get_env("APP_VERSION") || "1.0.0",
      elixir: "~> 1.20",
      elixirc_paths: ["lib"],
      start_permanent: Mix.env() == :prod,
      listeners: [Phoenix.CodeReloader],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {GamendHost.Application, []},
      extra_applications:
        [:logger, :runtime_tools, :swoosh, :sentry] ++
          if(Mix.env() == :prod, do: [:os_mon], else: [])
    ]
  end

  def cli do
    [
      preferred_envs: [precommit: :test, "precommit.full": :test]
    ]
  end

  # Only what this app adds on top of the engine — versions for everything else
  # come from gamend_web/gamend_core, whether they resolve as a sibling path
  # checkout or as Hex releases. A dep earns a line here only if the engine
  # does not declare it (sentry, castore, mix_audit), declares it `only: :dev`/
  # `only: :test` (Mix does not propagate those to a parent), or it is not on
  # Hex (heroicons).
  defp deps do
    [
      shared_dep(:gamend_core, "apps/gamend_core"),
      shared_dep(:gamend_web, "apps/gamend_web"),
      {:phoenix_live_reload, "~> 1.7", only: :dev},
      {:castore, "~> 1.0"},
      {:sentry, "~> 13.5"},
      {:credo, ">= 1.7.19", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.40", only: :dev, runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.2.0",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "db.setup", "assets.setup", "assets.build"],
      "dev.start": [
        "ecto.create --quiet -r Gamend.Repo",
        "db.migrate",
        "assets.build",
        "phx.server"
      ],
      "prod.start": ["assets.deploy", "db.setup", "phx.server"],
      "db.migrate": ["host.migrate -r Gamend.Repo"],
      "db.rollback": ["host.rollback -r Gamend.Repo"],
      "db.setup": ["host.db.setup"],
      "db.reset": ["host.db.reset"],
      test: ["ecto.create --quiet -r Gamend.Repo", "host.migrate --quiet -r Gamend.Repo", "test"],
      lint: ["format --check-formatted", "credo --strict"],
      # Light inner loop; precommit.full adds deps.audit, run before a push.
      precommit: [
        "compile --warnings-as-errors",
        "format",
        "test",
        "credo --strict",
        "gamend.api.lint"
      ],
      "precommit.full": ["precommit", "deps.audit"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["compile", "tailwind gamend_web", "esbuild gamend_web"],
      "assets.deploy": [
        "tailwind gamend_web --minify",
        "esbuild gamend_web --minify",
        "phx.digest",
        # After the digest, because it is the hashed copies that get served.
        # phx.digest writes .gz; this adds the .br that brotli_static wants.
        "cmd bin/compress-static"
      ]
    ]
  end

  # Two modes, and both have to work: the sibling checkout when you have one,
  # otherwise the Hex release a fresh clone and the Docker build use. No
  # `override:` on the Hex side — gamend_web asks for `gamend_core ~> 1.0`
  # there, which this app's requirement narrows, so they converge on their
  # own. Only the sibling path needs the engine's own source layout.
  #
  # The floor is the oldest release this code runs on. The lockfile holds no
  # engine entry (it is a path dep locally), so a build takes whatever Hex has;
  # without the floor a build that started before a release finished
  # publishing compiled against the one before it and failed on a function
  # that did not exist there yet. Raise it with any change that needs a newer
  # engine.
  @gamend_min "1.0.1266"

  defp shared_dep(app, local_path) do
    sibling_path = Path.join(@local_gamend_root, local_path)

    if source_app?(sibling_path) do
      {app, path: sibling_path}
    else
      {app, "~> 1.0 and >= #{@gamend_min}"}
    end
  end

  # A mix.exs is the proof it is really a source checkout — a bare directory
  # left behind by an earlier build is not.
  defp source_app?(path), do: File.regular?(Path.join(path, "mix.exs"))
end
