defmodule TheBigUsernameBlacklist.MixProject do
  use Mix.Project

  def project do
    [
      app: :the_big_username_blacklist,
      version: "0.2.0",
      elixir: "~> 1.3",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      maintainers: ["Darwin Christopher Tantuco"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/darwintantuco/the-big-username-blacklist"}
    ]
  end

  defp description() do
    """
    Elixir library for The-Big-Username-Blacklist (Opinionated username blacklist).
    """
  end
end
