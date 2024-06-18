defmodule Plotlyve.CsvManagement.CsvColumnData do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "csv_column_data" do
    field :column_name, :string
    field :values, {:array, :string}
    belongs_to :csv_metadata, Plotlyve.CsvManagement.CsvMetadata, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(csv_column_data, attrs) do
    csv_column_data
    |> cast(attrs, [:column_name, :values, :csv_metadata_id])
    |> validate_required([:column_name, :values, :csv_metadata_id])
  end
end
