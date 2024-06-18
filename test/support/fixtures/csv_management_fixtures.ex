defmodule Plotlyve.CsvManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Plotlyve.CsvManagement` context.
  """

  @doc """
  Generate a csv_metadata.
  """
  def csv_metadata_fixture(attrs \\ %{}) do
    {:ok, csv_metadata} =
      attrs
      |> Enum.into(%{
        columns: ["option1", "option2"],
        filename: "some filename"
      })
      |> Plotlyve.CsvManagement.create_csv_metadata()

    csv_metadata
  end

  @doc """
  Generate a csv_data.
  """
  def csv_data_fixture(attrs \\ %{}) do
    {:ok, csv_data} =
      attrs
      |> Enum.into(%{
        data: %{}
      })
      |> Plotlyve.CsvManagement.create_csv_data()

    csv_data
  end

  @doc """
  Generate a csv_column_data.
  """
  def csv_column_data_fixture(attrs \\ %{}) do
    {:ok, csv_column_data} =
      attrs
      |> Enum.into(%{
        column_name: "some column_name",
        values: ["option1", "option2"]
      })
      |> Plotlyve.CsvManagement.create_csv_column_data()

    csv_column_data
  end
end
