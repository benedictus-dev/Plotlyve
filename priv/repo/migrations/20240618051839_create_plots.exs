defmodule Plotlyve.Repo.Migrations.CreatePlots do
  use Ecto.Migration

  def change do
    create table(:plots, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :expression, :string
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      add :csv_metadata_id, references(:csv_metadata, type: :binary_id, on_delete: :delete_all),
        null: false

      timestamps(type: :utc_datetime)
    end
  end
end
