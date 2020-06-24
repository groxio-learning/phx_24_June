defmodule RecuerdoWeb.CounterLive do
  use RecuerdoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
      count: 0
      )
    IO.inspect socket
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>
      <%= @count %>
    </h1>
    <button phx-click="change">
      Increment
    </button>
    """
  end


end
