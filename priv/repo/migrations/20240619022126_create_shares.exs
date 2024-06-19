defmodule Plotlyve.Repo.Migrations.CreateShares do
  use Ecto.Migration

  def change do
    create table(:shares, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :dataclip_id, :binary
      add :user_id, :binary

      timestamps(type: :utc_datetime)
    end
  end
end
