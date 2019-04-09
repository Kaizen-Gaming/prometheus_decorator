# PrometheusDecorator

An Elixir function decorator for application metrics

## Installation

Add `:prometheus_decorator` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:prometheus_decorator, github: "StoiximanServices/prometheus_decorator"}
  ]
end
```

## Usage

When you have a function that does some calculations and want to increment or decrement the counter or gauge of the progress of its execution, you should do the following:

```elixir
@decorate counter_inc(:complex_calc_label)
def calc_complex_stuff, do: complex_calculations()

@decorate gauge_dec(:complex_calc_label)
def calc_complex_stuff, do: complex_calculations()

@decorate gauge_inc(:complex_calc_label)
def calc_complex_stuff, do: complex_calculations()
```

When you have a function that does some calculations and depending on the result, increment or decrement the respective counter or gauge respectively, you should do the following:

```elixir
@decorate counter_result(:successful_complex_calc_label, :failed_complex_calc_label)
def calc_complex_stuff, do: complex_calculations()

@decorate gauge_result(:successful_complex_calc_label, :failed_complex_calc_label)
def calc_complex_stuff, do: complex_calculations()
```

When you have a function that does some calculations and want to measure in a histogram the duration of its execution, you should do the following:

```elixir
@decorate histogram_observe(:complex_calc_seconds)
def calc_complex_stuff, do: complex_calculations()
```

When you have a function that does some calculations and want to measure in a summary the duration of its execution, you should do the following:

```elixir
@decorate summary_observe(:complex_calc_seconds)
def calc_complex_stuff, do: complex_calculations()
```