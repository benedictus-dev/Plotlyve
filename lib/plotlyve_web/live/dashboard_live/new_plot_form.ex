defmodule PlotlyveWeb.DashboardLive.NewPlotForm do
  alias PlotlyveWeb.DashboardLive.NewPlotForm
  import Ecto.Changeset
  defstruct [:name, :user_id]
  @types %{name: :string, user_id: Ecto.UUID}

  def changeset(%__MODULE__{} = plot, attrs) do
    {plot, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:name, :user_id])
  end

  def change_plot(plot, attrs \\ %{}) do
    NewPlotForm.changeset(plot, attrs)
  end
end
