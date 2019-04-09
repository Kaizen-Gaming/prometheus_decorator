defmodule PrometheusDecorator.MixProject do
  use Mix.Project

  def project do
    [
      app: :prometheus_decorator,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0", runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", runtime: false},
      {:decorator, "~> 1.3"},
      {:ex_doc, "~> 0.20.1", only: :dev, runtime: false},
      {:prometheus_ex, "~> 3.0"}
    ]
  end
end
