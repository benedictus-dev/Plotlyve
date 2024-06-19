defmodule Plotlyve.CsvManagement.Dataclip do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "dataclips" do
    field :dataclip,  {:array, :string}
    belongs_to :plot, Plotlyve.Plots.Plot, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(dataclip, attrs) do
    dataclip
    |> cast(attrs, [:plot_id, :dataclip])
    |> validate_required([:plot_id,:dataclip])
  end
end
