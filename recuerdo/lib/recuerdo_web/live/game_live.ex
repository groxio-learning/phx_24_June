defmodule RecuerdoWeb.GameLive do
  use RecuerdoWeb, :live_view
  alias Recuerdo.Model

  @impl true
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, any}
  def mount(_params, _session, socket) do
    {:ok, new_eraser(socket)}
  end

  def render(assigns) do
    ~L"""
    <h1>Recuerdo!</h1>
    <p><%= @eraser.current_text %></p>
    <button phx-click="erase">Erase!</button>
    <button <%= disabled?(@eraser) %> phx-click="play_again">Play Again</button>
    <pre><%= inspect @eraser %></pre>
    """
  end

  def handle_event("erase", _, socket) do
    {:noreply, socket |> erase()}
  end

  def handle_event("play_again", _, socket) do
    {:noreply, new_eraser(socket)}
  end

  defp erase(socket) do
    new_eraser =
      socket.assigns.eraser
      |> Model.erase()

    assign(socket, eraser: new_eraser)
  end

  def new_eraser(socket) do
    text = Speech.random_passage()
    steps = 5
    eraser = Model.new(text, steps)
    assign(socket, eraser: eraser)
  end

  def disabled?(eraser) do
    unless Model.finished?(eraser) do
      "disabled"
    end
  end
end
