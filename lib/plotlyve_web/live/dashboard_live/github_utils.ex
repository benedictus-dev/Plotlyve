defmodule PlotlyveWeb.DashboardLive.Utils do
  alias Plotlyve.Repo
  alias Plotlyve.CsvManagement.{CsvMetadata, CsvColumnData}

  require Logger
  alias HTTPoison
  @github_url "https://raw.githubusercontent.com/plotly/datasets/master/"

  def fetch_csv_files(filenames) when is_list(filenames) do
    Enum.each(filenames, &fetch_csv_file/1)
  end

  def fetch_csv_file(filename) do
    url = @github_url <> filename
    download_and_parse_csv(url, filename)
  end

  defp download_and_parse_csv(url, filename) do
    Logger.info("Fetching CSV from #{url}")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info("Successfully fetched CSV from #{url}")
        parse_and_store_csv(body, filename)

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error("Failed to download #{url}, status code: #{status_code}")
        Logger.error("Response body: #{body}")

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Failed to download #{url}, reason: #{reason}")
    end
  end

  defp parse_and_store_csv(body, filename) do
    [headers | rows] = NimbleCSV.RFC4180.parse_string(body, skip_headers: false)

    Logger.info("Parsed headers: #{inspect(headers)}")

    # Transpose rows to columns
    columns =
      for col <- headers,
          do: {col, Enum.map(rows, &Enum.at(&1, Enum.find_index(headers, fn x -> x == col end)))}

    # Store metadata
    case %CsvMetadata{}
         |> CsvMetadata.changeset(%{filename: filename, columns: headers})
         |> Repo.insert() do
      {:ok, metadata} ->
        Logger.info("Successfully stored metadata for #{filename}")

        # Store columns data
        Enum.each(columns, fn {col_name, values} ->
          %CsvColumnData{}
          |> CsvColumnData.changeset(%{
            column_name: col_name,
            values: values,
            csv_metadata_id: metadata.id
          })
          |> Repo.insert!()
        end)

        Logger.info("Stored CSV Column Data for #{filename}")

      {:error, changeset} ->
        Logger.error("Failed to store metadata for #{filename}: #{inspect(changeset)}")
    end
  end
end
