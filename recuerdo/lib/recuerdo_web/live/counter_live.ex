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
    <button phx-click="change" phx-value-direction="increment">
      Increment
    </button>
    <button phx-click="change" phx-value-direction="decrement">
      Decrement
    </button>
    """
  end

  defp change(socket, "increment") do
    assign(socket,
      count: Counter.increment(socket.assigns.count)
    )
  end

  defp change(socket, "decrement") do
    assign(socket,
      count: Counter.decrement(socket.assigns.count)
    )
  end

  def handle_event("change", %{"direction" => direction}, socket) do
    {:noreply, socket |> change(direction)}
  end
end
