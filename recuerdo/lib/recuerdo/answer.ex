defmodule Recuerdo.Answer do
  alias Ecto.Changeset

  @types %{answer: :string}
  def change_answer(params) do
    answer = %{}

    {answer, @types}
    |> Changeset.cast(params, Map.keys(@types))
  end
end
