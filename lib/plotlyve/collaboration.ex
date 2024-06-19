defmodule Plotlyve.Collaboration do
  @moduledoc """
  The Collaboration context.
  """

  import Ecto.Query, warn: false
  alias Plotlyve.{Repo, Plots}

  alias Plotlyve.Collaboration.Share

  @doc """
  Returns the list of shares.

  ## Examples

      iex> list_shares()
      [%Share{}, ...]

  """
  def list_shares do
    Repo.all(Share)
  end

  @doc """
  Gets a single share.

  Raises `Ecto.NoResultsError` if the Share does not exist.

  ## Examples

      iex> get_share!(123)
      %Share{}

      iex> get_share!(456)
      ** (Ecto.NoResultsError)

  """
  def get_share!(id), do: Repo.get!(Share, id)

  @doc """
  Creates a share.

  ## Examples

      iex> create_share(%{field: value})
      {:ok, %Share{}}

      iex> create_share(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_share(attrs \\ %{}) do
    %Share{}
    |> Share.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a share.

  ## Examples

      iex> update_share(share, %{field: new_value})
      {:ok, %Share{}}

      iex> update_share(share, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_share(%Share{} = share, attrs) do
    share
    |> Share.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a share.

  ## Examples

      iex> delete_share(share)
      {:ok, %Share{}}

      iex> delete_share(share)
      {:error, %Ecto.Changeset{}}

  """
  def delete_share(%Share{} = share) do
    Repo.delete(share)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking share changes.

  ## Examples

      iex> change_share(share)
      %Ecto.Changeset{data: %Share{}}

  """
  def change_share(%Share{} = share, attrs \\ %{}) do
    Share.changeset(share, attrs)
  end

  def get_plot_viewers(dataclip_id) do
    query =
      from sh in Share,
        where: sh.dataclip_id == ^dataclip_id,
        select: sh.user_id

    query |> Repo.all()
  end
end
