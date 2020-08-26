defmodule CounterWeb.PageLive do
  use CounterWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Counter.Store.subscribe_to_count()

    {:ok, assign(socket, val: Counter.Store.value())}
  end

  @impl true
  def handle_event("inc", _value, socket) do
    Counter.Store.inc()

    {:noreply, socket}
  end

  @impl true
  def handle_event("dec", _value, socket) do
    Counter.Store.dec()

    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "update_val", payload: %{value: val}}, socket) do
    {:noreply, assign(socket, val: val)}
  end
end
