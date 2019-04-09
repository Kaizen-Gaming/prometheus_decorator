defmodule PrometheusDecoratorTest do
  use ExUnit.Case
  doctest PrometheusDecorator

  test "greets the world" do
    assert PrometheusDecorator.hello() == :world
  end
end
