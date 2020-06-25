defmodule Recuerdo.Repo.Migrations.CreatePassages do
  use Ecto.Migration

  def change do
    create table(:passages) do
      add :name, :string
      add :text, :text
      add :steps, :integer

      timestamps()
    end

  end
end
