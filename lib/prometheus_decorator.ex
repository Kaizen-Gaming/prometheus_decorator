defmodule PrometheusDecorator do
  @moduledoc """
  This is an API that provides a useful abstraction when you need to implement
  a metrics infrastructure using [Prometheus.ex](https://hex.pm/packages/prometheus_ex).
  """

  use Decorator.Define,
    counter_inc: 1,
    counter_result: 2,
    gauge_dec: 1,
    gauge_inc: 1,
    gauge_result: 2,
    histogram_observe: 1,
    summary_observe: 1

  use Prometheus.Metric

  @doc """
  When called, it will increment the counter of the passed label and move on
  with the execution of the function body.
  """
  @spec counter_inc(atom, term, term) :: term
  def counter_inc(label, body, _context) do
    quote do
      Counter.inc(unquote(label))
      unquote(body)
    end
  end

  @doc """
  When called, it will increment or decrement the counter of the passed labels respectively
  depending on the result of the function body, and move on with its execution.
  """
  @spec counter_result(atom, atom, term, term) :: term
  def counter_result(success_label, failure_label, body, _context) do
    quote do
      result = unquote(body)

      case result do
        :ok -> Counter.inc(unquote(success_label))
        {:ok, _} -> Counter.inc(unquote(success_label))
        :error -> Counter.inc(unquote(failure_label))
        {:error, _} -> Counter.inc(unquote(failure_label))
        {:error, _, _} -> Counter.inc(unquote(failure_label))
        _ -> nil
      end

      result
    end
  end

  @doc """
  When called, it will decrement the gauge of the passed label and move on
  with the execution of the function body.
  """
  @spec gauge_dec(atom, term, term) :: term
  def gauge_dec(label, body, _context) do
    quote do
      Gauge.dec(unquote(label))
      unquote(body)
    end
  end

  @doc """
  When called, it will increment the gauge of the passed label and move on
  with the execution of the function body.
  """
  @spec gauge_inc(atom, term, term) :: term
  def gauge_inc(label, body, _context) do
    quote do
      Gauge.inc(unquote(label))
      unquote(body)
    end
  end

  @doc """
  When called, it will increment or decrement the gauge of the passed labels respectively
  depending on the result of the function body, and move on with its execution.
  """
  @spec gauge_result(atom, atom, term, term) :: term
  def gauge_result(success_label, failure_label, body, _context) do
    quote do
      result = unquote(body)

      case result do
        :ok -> Gauge.inc(unquote(success_label))
        {:ok, _} -> Gauge.inc(unquote(success_label))
        :error -> Gauge.inc(unquote(failure_label))
        {:error, _} -> Gauge.inc(unquote(failure_label))
        {:error, _, _} -> Gauge.inc(unquote(failure_label))
        _ -> nil
      end

      result
    end
  end

  @doc """
  When called, it will keep a timestamp before and after the execution of the
  function body, and observe the duration in a histogram.
  """
  @spec histogram_observe(atom, term, term) :: term
  def histogram_observe(label, body, _context) do
    quote do
      start = System.monotonic_time()
      result = unquote(body)
      duration = System.monotonic_time() - start
      Histogram.observe(unquote(label), duration)
      result
    end
  end

  @doc """
  When called, it will keep a timestamp before and after the execution of the
  function body, and observe the duration in a summary.
  """
  @spec summary_observe(atom, term, term) :: term
  def summary_observe(label, body, _context) do
    quote do
      start = System.monotonic_time()
      result = unquote(body)
      duration = System.monotonic_time() - start
      Summary.observe(unquote(label), duration)
      result
    end
  end
end
