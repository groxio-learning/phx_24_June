defmodule RecuerdoWeb.GameLive do
  use RecuerdoWeb, :live_view

  alias Phoenix.PubSub
  alias Recuerdo.{Answer, Model, Library}
  alias Recuerdo.Library.Passage

  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, any}
  def mount(_params, _session, socket) do
    PubSub.subscribe(Recuerdo.PubSub, "library-passage-added")

    {
      :ok,
      assign(socket,
        eraser: nil,
        changeset: Passage.nameless_changeset(%Passage{}, %{}),
        answer_changeset: Answer.change_answer(%{}),
        score: 0
      )
      |> set_passage_names()
    }
  end

  defp set_passage_names(socket) do
    assign(socket, passage_names: Recuerdo.Library.passage_names())
  end

  @spec handle_event(<<_::32, _::_*8>>, any, Phoenix.LiveView.Socket.t()) :: {:noreply, any}
  def handle_event("erase", _, socket) do
    {:noreply, socket |> erase()}
  end

  def handle_event("play_again", _, socket) do
    {:noreply, assign(socket, eraser: nil)}
  end

  def handle_event("validate", %{"passage" => params}, socket) do
    {:noreply, socket |> validate(params)}
  end

  def handle_event("save", %{"passage" => params}, socket) do
    {:noreply, socket |> save(params)}
  end

  def handle_event("passage", %{"name" => name}, socket) do
    {:noreply, socket |> select_passage(name)}
  end

  def handle_event("score", %{"answer" => params}, socket) do
    {:noreply, socket |> score(params["answer"])}
  end

  def handle_info("some name", socket) do
    {:noreply, socket |> set_passage_names}
  end

  defp select_passage(socket, name) do
    passage = Library.find_passage_by_name(name)
    new_eraser(socket, passage.text, passage.steps)
  end

  defp erase(socket) do
    new_eraser =
      socket.assigns.eraser
      |> Model.erase()

    assign(socket, eraser: new_eraser)
  end

  def validate(socket, params) do
    assign(socket, changeset: Passage.nameless_changeset(%Passage{}, params))
  end

  def save(socket, params) do
    new_eraser(socket, params["text"], String.to_integer(params["steps"]))
  end

  def new_eraser(socket, text, steps) do
    eraser = Model.new(text, steps)
    assign(socket, eraser: eraser)
  end

  def disabled?(eraser) do
    unless Model.finished?(eraser) do
      "disabled"
    end
  end

  def score(socket, answer) do
    assign(socket, score: Model.score(socket.assigns.eraser, answer))
  end


end
