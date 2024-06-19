defmodule Plotlyve.Plots.Plot do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "plots" do
    field :name, :string
    field :expression, :string
    belongs_to :csv_metadata, Plotlyve.CsvManagement.CsvMetadata, type: :binary_id
    belongs_to :user, Plotlyve.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plot, attrs) do
    plot
    |> cast(attrs, [:name, :expression, :user_id, :csv_metadata_id])
    |> validate_required([:name, :expression, :user_id, :csv_metadata_id])
  end
end
