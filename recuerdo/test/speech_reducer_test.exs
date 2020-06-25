defmodule Recuerdo.SpeechReducerTest do
  use ExUnit.Case, async: true

  alias Recuerdo.SpeechReducer

  test "gets all underbars on the last step" do
    model =
      SpeechReducer.new("abcd", 1)
      |> SpeechReducer.erase()

    assert model.history == ["____", "abcd"]
  end

  test "new populates the original into history" do
    model = SpeechReducer.new("abcd", 1)
    assert model.history == ["abcd"]
  end

  test "erasing once adds something to the history list" do
    model =
      SpeechReducer.new("abcd", 1)
      |> SpeechReducer.erase()

    assert Enum.count(model.history) == 2
  end

  test "current_step increments on each erase" do
    model = SpeechReducer.new("abcd", 4)
    assert model.current_step == 1
    model = SpeechReducer.erase(model)
    assert model.current_step == 2
    model = SpeechReducer.erase(model)
    assert model.current_step == 3
    model = SpeechReducer.erase(model)
    assert model.current_step == 4
    assert ["____" | _] = model.history
  end
end
