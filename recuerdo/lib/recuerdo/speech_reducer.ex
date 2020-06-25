defmodule Recuerdo.SpeechReducer do
  # Constructor is new(text, steps)
  # Reducer is erase(model)

  alias Recuerdo.SpeechReducer

  defstruct text: "", steps: 1, current_step: 1, history: []

  def new(text, steps) do
    # returns a new model
    %SpeechReducer{ text: text, steps: steps, history: [text] }
  end

  def erase(model = %SpeechReducer{ history: history }) do
    # In the last step, probability should be 100%.
    # In step 2 of 3, prob should be 66%.
    # In step 1 of 3, prob shoudl be 33%.
    probability = model.current_step / model.steps * 100
    new_text =
      model.text
      |> String.graphemes()
      |> Enum.map(fn char -> if Enum.random(1..100) <= probability do "_" else char end end)
      |> Enum.join("")
    %SpeechReducer{ model | text: new_text, history: [new_text | history], current_step: model.current_step + 1}
  end
end
