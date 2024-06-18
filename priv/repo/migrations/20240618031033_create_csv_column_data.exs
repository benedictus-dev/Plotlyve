defmodule Plotlyve.Repo.Migrations.CreateCsvColumnData do
  use Ecto.Migration

  def change do
    create table(:csv_column_data, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :column_name, :string, null: false
      add :values, {:array, :string}, null: false
      add :csv_metadata_id, references(:csv_metadata, on_delete: :delete_all, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:csv_column_data, [:csv_metadata_id])
  end
end
