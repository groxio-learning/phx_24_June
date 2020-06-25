defmodule Recuerdo.Library.Passage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passages" do
    field :name, :string
    field :steps, :integer, default: 5
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(passage, attrs) do
    passage
    |> cast(attrs, [:name, :text, :steps])
    |> validate_required([:name, :text, :steps])
  end

  @doc false
  def nameless_changeset(passage, attrs) do
    passage
    |> cast(attrs, [:text, :steps])
    |> validate_required([:text, :steps])
    |> validate_length(:text, min: 5)
    |> validate_number(:steps, greater_than: 3)
    |> Map.put(:action, :validate)
  end
end
