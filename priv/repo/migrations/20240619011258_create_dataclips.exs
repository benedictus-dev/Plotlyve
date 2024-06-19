defmodule Plotlyve.Repo.Migrations.CreateDataclips do
  use Ecto.Migration

  def change do
    create table(:dataclips, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :dataclip,  {:array, :string}, null: false
      add :plot_id, references(:plots, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:dataclips, [:plot_id])
  end
end
