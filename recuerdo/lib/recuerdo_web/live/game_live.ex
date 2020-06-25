defmodule RecuerdoWeb.GameLive do
  use RecuerdoWeb, :live_view
  alias Recuerdo.Model

  @impl true
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, any}
  def mount(_params, _session, socket) do
    text = Speech.random_passage()
    steps = 5
    eraser = Model.new(text, steps)
    socket = assign(socket, eraser: eraser)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Recuerdo!</h1>
    <p><%= @eraser.current_text %></p>
    <button phx-click="erase">Erase!</button>
    <pre><%= inspect @eraser %></pre>
    """
  end

  def handle_event("erase", _, socket) do
    {:noreply, socket |> erase()}
  end

  defp erase(socket) do
    new_eraser =
      socket.assigns.eraser
      |> Model.erase()

    assign(socket, eraser: new_eraser)
  end
end
