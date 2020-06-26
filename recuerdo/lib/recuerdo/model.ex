defmodule Recuerdo.Model do
  @enforce_keys [:original_text, :current_text, :schedule]
  defstruct [:original_text, :current_text, :schedule ]

  @type t :: %__MODULE__{
          original_text: String.t(),
          current_text: String.t(),
          schedule: [MapSet.t(integer)]
        }

  @do_not_erase ~r/^[[:space:][:punct:]]$/

  @spec new(String.t(), integer) :: t
  def new(text, steps) do
    %__MODULE__{
      original_text: text,
      current_text: text,
      schedule: make_schedule(text, steps)
    }
  end

  @spec erase(t) :: t
  def erase(model = %__MODULE__{schedule: []} ) do
    model
  end

  def erase(model = %__MODULE__{schedule: [deletions | new_schedule]} ) do

    new_text =
      model.current_text
      |> apply_deletions(deletions)

    %__MODULE__{
      original_text: model.original_text,
      current_text: new_text,
      schedule: new_schedule
    }

  end

  def score(model, answer) do

      model.original_text
      |> String.myers_difference(answer)
      |> Enum.reject(fn {action, _str} -> action == :eq end)
      |> Enum.map(fn {_a, string} -> String.length(string) end)
      |> Enum.sum

  end

  @spec make_schedule(String.t(), integer) :: [MapSet.t(integer)]
  def make_schedule(text, steps) do
    length = String.length(text)
    chunk_size = ceil(length / steps)

    0..(length - 1)
    |> Enum.to_list()
    |> Enum.shuffle()
    |> Enum.chunk_every(chunk_size)
    |> Enum.map(&MapSet.new/1)
  end

  @spec apply_deletions(String.t(), MapSet.t(integer)) :: String.t()
  def apply_deletions(text, deletions) do
    text
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {char, index} ->
      char
      |> maybe_erase_grapheme(MapSet.member?(deletions, index))
    end)
    |> Enum.join()
  end

  @spec maybe_erase_grapheme(String.t(), boolean) :: String.t()
  def maybe_erase_grapheme(grapheme, _is_scheduled_to_erase = false) do
    grapheme
  end

  def maybe_erase_grapheme(grapheme, _is_scheduled_to_erase = true) do
    if Regex.match?(@do_not_erase, grapheme) do
      grapheme
    else
      "_"
    end
  end

  def finished?(%{schedule: []}), do: true
  def finished?(_model), do: false


end
