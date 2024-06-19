defmodule PlotlyveWeb.DashboardLive.SelectUser do
  alias PlotlyveWeb.DashboardLive.SelectUser
  import Ecto.Changeset
  defstruct [:email]
  @types %{email: :string}

  def changeset(%__MODULE__{} = email, attrs) do
    {email, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:email])
  end

  def change_user(attrs \\ %{}) do
    %SelectUser{}
    |> SelectUser.changeset(attrs)
  end
end
