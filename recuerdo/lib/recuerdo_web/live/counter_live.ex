defmodule RecuerdoWeb.CounterLive do
  use RecuerdoWeb, :live_view
  alias Recuerdo.Counter

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        count: 0
      )

    # IO.inspect(socket)
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

  defp increment(socket) do
    assign(socket,
      count: Counter.increment(socket.assigns.count)
    )
  end

  def handle_event("change", _, socket) do
    {:noreply, socket |> increment()}
  end
end
