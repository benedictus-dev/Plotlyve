defmodule Plotlyve.Repo.Migrations.CreateCsvMetadata do
  use Ecto.Migration

  def change do
    create table(:csv_metadata, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :filename, :string, null: false
      add :columns, {:array, :string}, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:csv_metadata, [:filename])
  end
end
