defmodule Plotlyve.CsvManagement do
  @moduledoc """
  The CsvManagement context.
  """

  import Ecto.Query, warn: false
  alias Plotlyve.Repo

  alias Plotlyve.CsvManagement.CsvMetadata

  @doc """
  Returns the list of csv_metadata.

  ## Examples

      iex> list_csv_metadata()
      [%CsvMetadata{}, ...]

  """
  def list_csv_metadata do
    Repo.all(CsvMetadata)
  end

  @doc """
  Gets a single csv_metadata.

  Raises `Ecto.NoResultsError` if the Csv metadata does not exist.

  ## Examples

      iex> get_csv_metadata!(123)
      %CsvMetadata{}

      iex> get_csv_metadata!(456)
      ** (Ecto.NoResultsError)

  """
  def get_csv_metadata!(id), do: Repo.get!(CsvMetadata, id)

  @doc """
  Creates a csv_metadata.

  ## Examples

      iex> create_csv_metadata(%{field: value})
      {:ok, %CsvMetadata{}}

      iex> create_csv_metadata(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_csv_metadata(attrs \\ %{}) do
    %CsvMetadata{}
    |> CsvMetadata.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a csv_metadata.

  ## Examples

      iex> update_csv_metadata(csv_metadata, %{field: new_value})
      {:ok, %CsvMetadata{}}

      iex> update_csv_metadata(csv_metadata, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_csv_metadata(%CsvMetadata{} = csv_metadata, attrs) do
    csv_metadata
    |> CsvMetadata.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a csv_metadata.

  ## Examples

      iex> delete_csv_metadata(csv_metadata)
      {:ok, %CsvMetadata{}}

      iex> delete_csv_metadata(csv_metadata)
      {:error, %Ecto.Changeset{}}

  """
  def delete_csv_metadata(%CsvMetadata{} = csv_metadata) do
    Repo.delete(csv_metadata)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking csv_metadata changes.

  ## Examples

      iex> change_csv_metadata(csv_metadata)
      %Ecto.Changeset{data: %CsvMetadata{}}

  """
  def change_csv_metadata(%CsvMetadata{} = csv_metadata, attrs \\ %{}) do
    CsvMetadata.changeset(csv_metadata, attrs)
  end

  alias Plotlyve.CsvManagement.CsvColumnData

  @doc """
  Returns the list of csv_column_data.

  ## Examples

      iex> list_csv_column_data()
      [%CsvColumnData{}, ...]

  """
  def list_csv_column_data do
    Repo.all(CsvColumnData)
  end

  @doc """
  Gets a single csv_column_data.

  Raises `Ecto.NoResultsError` if the Csv column data does not exist.

  ## Examples

      iex> get_csv_column_data!(123)
      %CsvColumnData{}

      iex> get_csv_column_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_csv_column_data!(id), do: Repo.get!(CsvColumnData, id)

  @doc """
  Creates a csv_column_data.

  ## Examples

      iex> create_csv_column_data(%{field: value})
      {:ok, %CsvColumnData{}}

      iex> create_csv_column_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_csv_column_data(attrs \\ %{}) do
    %CsvColumnData{}
    |> CsvColumnData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a csv_column_data.

  ## Examples

      iex> update_csv_column_data(csv_column_data, %{field: new_value})
      {:ok, %CsvColumnData{}}

      iex> update_csv_column_data(csv_column_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_csv_column_data(%CsvColumnData{} = csv_column_data, attrs) do
    csv_column_data
    |> CsvColumnData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a csv_column_data.

  ## Examples

      iex> delete_csv_column_data(csv_column_data)
      {:ok, %CsvColumnData{}}

      iex> delete_csv_column_data(csv_column_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_csv_column_data(%CsvColumnData{} = csv_column_data) do
    Repo.delete(csv_column_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking csv_column_data changes.

  ## Examples

      iex> change_csv_column_data(csv_column_data)
      %Ecto.Changeset{data: %CsvColumnData{}}

  """
  def change_csv_column_data(%CsvColumnData{} = csv_column_data, attrs \\ %{}) do
    CsvColumnData.changeset(csv_column_data, attrs)
  end

  @doc """
  Retrieves column data by metadata filename.

  ## Examples

      iex> get_column_data_by_filename("example.csv")
      [%CsvColumnData{}, ...]

  """
  def get_column_data_by_filename(filename) do
    query =
      from cm in CsvMetadata,
        join: cc in CsvColumnData,
        on: cc.csv_metadata_id == cm.id,
        where: cm.filename == ^filename,
        select: cc

    Repo.all(query)
  end

  @doc """
  Retrieves column data by column name and metadata filename.

  ## Examples

      iex> get_column_data_by_column_name_and_filename("example.csv", "Name")
      [%CsvColumnData{}, ...]

  """
  def get_column_data_by_column_name_and_filename(filename, column_name) do
    query =
      from cm in CsvMetadata,
        join: cc in CsvColumnData,
        on: cc.csv_metadata_id == cm.id,
        where: cm.filename == ^filename and cc.column_name == ^column_name,
        select: cc

    Repo.all(query)
  end
end
