defmodule Counter.Store do
  use Agent

  @count_bucket "count"

  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def value() do
    Agent.get(__MODULE__, & &1)
  end

  def inc() do
    Agent.update(__MODULE__, fn state -> state + 1 end)

    CounterWeb.Endpoint.broadcast(@count_bucket, "update_val", %{value: value()})
  end

  def dec() do
    Agent.update(__MODULE__, fn state -> state - 1 end)

    CounterWeb.Endpoint.broadcast(@count_bucket, "update_val", %{value: value()})
  end

  def subscribe_to_count() do
    CounterWeb.Endpoint.subscribe(@count_bucket)
  end
end
