defmodule GithubUserSearchApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :github_user_search_app,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {GithubUserSearchApp.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:sobelow, "~> 0.8", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:mox, "~> 1.0", only: :test},
      {:dotenv, "~> 3.0.0", only: [:dev, :test]},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:finch, "~> 0.13"},
      {:phoenix, "~> 1.6.13"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:timex, "~> 3.7"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      ci: [
        "ci.deps_and_security",
        "ci.formatting",
        "ci.code_quality",
        "ci.test"
        # "ci.migrations"
      ],
      "ci.code_quality": [
        "compile --force --warnings-as-errors",
        "credo --strict",
        "dialyzer"
      ],
      "ci.deps_and_security": [
        "deps.unlock --check-unused",
        "deps.audit",
        "hex.audit",
        "sobelow --config .sobelow-conf"
      ],
      "ci.formatting": ["format --check-formatted", "cmd --cd assets npx prettier -c .."],
      "ci.migrations": ["ecto.migrate --quiet", "ecto.rollback --all --quiet"],
      "ci.test": [
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "test --cover --warnings-as-errors"
      ],
      prettier: ["cmd --cd assets npx prettier -w .."]
    ]
  end
end
