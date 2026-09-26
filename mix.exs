# Rename this module to match your project, e.g. MyGame.MixProject
# Also update: app: :my_game, name: "MyGame"
# and the Application module reference in application/0 below.
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
      elixir: "~> 1.19",
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
      test:
        [
          "ecto.create --quiet -r Gamend.Repo",
          "host.migrate --quiet -r Gamend.Repo",
          "test"
        ] ++ local_web_commands([web_test_cmd("deps.get"), web_test_cmd("test")]),
      # gamend's CI runs `mix credo --strict` twice — once at the umbrella root,
      # which sees both apps *and* their tests, and once inside apps/gamend_web.
      # The per-app run alone leaves the root-only files unchecked, so a finding
      # can pass here and fail there.
      lint:
        ["format --check-formatted", "credo --strict"] ++
          local_web_commands([
            web_cmd("format --check-formatted"),
            gamend_root_cmd("credo --strict"),
            web_cmd("credo --strict")
          ]),
      # Light inner loop; the web-app compile/lint and audit live in
      # precommit.full, run before a push.
      precommit: [
        "compile --warnings-as-errors",
        "format",
        "test",
        "credo --strict",
        "gamend.api.lint"
      ],
      "precommit.full":
        ["precommit"] ++
          local_web_commands([
            web_test_cmd("deps.get"),
            web_test_cmd("compile --warnings-as-errors"),
            web_cmd("format"),
            web_cmd("credo --strict")
          ]) ++ ["deps.audit"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["compile", "tailwind gamend_web", "esbuild gamend_web"],
      "assets.deploy": [
        "tailwind gamend_web --minify",
        "esbuild gamend_web --minify",
        "phx.digest"
      ]
    ]
  end

  defp web_cmd(task), do: "cmd --cd #{web_app_path()} mix #{task}"

  # The umbrella root itself — the scope gamend's CI credo runs in, which sees
  # both apps plus their tests and so covers files no per-app run reaches.
  defp gamend_root_cmd(task), do: "cmd --cd #{@local_gamend_root} mix #{task}"
  defp web_test_cmd(task), do: "cmd --cd #{web_app_path()} env MIX_ENV=test mix #{task}"

  defp local_web_commands(commands) do
    if local_web_source?(), do: commands, else: []
  end

  # The engine's own suite and credo run only against a sibling checkout. A Hex
  # package ships mix.exs but no tests and no dev dependencies, so treating one
  # as a source checkout would run `mix test` in a directory that has none.
  defp local_web_source?, do: source_app?(web_app_path())

  defp web_app_path, do: Path.join(@local_gamend_root, "apps/gamend_web")

  # Two modes, and both have to work: the sibling checkout when you have one,
  # otherwise the Hex release a fresh clone and the Docker build use. No
  # `override:` on the Hex side — gamend_web asks for `gamend_core ~> 1.0`
  # there, which is the same requirement this app states, so they converge on
  # their own. Only the sibling path needs the engine's own source layout.
  defp shared_dep(app, local_path) do
    sibling_path = Path.join(@local_gamend_root, local_path)

    if source_app?(sibling_path) do
      {app, path: sibling_path}
    else
      {app, "~> 1.0"}
    end
  end

  # A mix.exs is the proof it is really a source checkout — a bare directory
  # left behind by an earlier build is not.
  defp source_app?(path), do: File.regular?(Path.join(path, "mix.exs"))
end
