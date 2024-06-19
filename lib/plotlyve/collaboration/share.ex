defmodule Plotlyve.Collaboration.Share do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shares" do
    field :dataclip_id, :binary
    field :user_id, :binary

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(share, attrs) do
    share
    |> cast(attrs, [:dataclip_id, :user_id])
    |> validate_required([:dataclip_id, :user_id])
  end
end
