[
  import_deps: [:ecto, :ecto_sql, :phoenix],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  subdirectories: ["priv/*/migrations"],
  # Anchored at this project, not `../..`. These globs were written for an app
  # living inside an umbrella's `apps/<name>/`; from this project's own root the
  # same patterns climb out into whatever sibling checkouts happen to sit beside
  # it, so `mix format` reached into unrelated repos and `mix lint` failed on
  # their files.
  inputs: [
    "*.{heex,ex,exs}",
    "config/**/*.{heex,ex,exs}",
    "{lib,test}/**/*.{heex,ex,exs}",
    "priv/*/seeds.exs"
  ]
]
