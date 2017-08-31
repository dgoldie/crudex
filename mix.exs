defmodule Crudex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :crudex,
      version: "0.1.0",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env == :prod,
      # description: description,
      # package: package,
      deps: deps()
    ]
  end

  # defp description do
  #   """
  #   Macro that adds CRUD functions to your Phoenix context for a schema.
  #   """
  # end

  # defp package do
  #   [
  #    files: ["lib", "mix.exs", "README.md"],
  #    maintainers: ["Doug Goldie"],
  #    licenses: ["Apache 2.0"],
  #    links: %{"GitHub" => "https://github.com/dgoldie/crudex",
  #             "Docs" => "https://hexdocs.pm/crudex/"}
  #    ]
  #  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
