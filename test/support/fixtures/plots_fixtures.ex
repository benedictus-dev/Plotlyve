defmodule Plotlyve.PlotsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Plotlyve.Plots` context.
  """

  @doc """
  Generate a plot.
  """
  def plot_fixture(attrs \\ %{}) do
    {:ok, plot} =
      attrs
      |> Enum.into(%{
        csv_metadata_id: "7488a646-e31f-11e4-aace-600308960662",
        expression: "some expression",
        name: "some name",
        user_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Plotlyve.Plots.create_plot()

    plot
  end
end
