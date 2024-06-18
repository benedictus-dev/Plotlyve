defmodule Plotlyve.CsvManagement.CsvMetadata do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "csv_metadata" do
    field :filename, :string
    field :columns, {:array, :string}

    has_many :csv_column_data, Plotlyve.CsvManagement.CsvColumnData

    timestamps()
  end

  @doc false
  def changeset(csv_metadata, attrs) do
    csv_metadata
    |> cast(attrs, [:filename, :columns])
    |> validate_required([:filename, :columns])
  end
end
