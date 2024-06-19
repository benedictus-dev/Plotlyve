defmodule Plotlyve.CollaborationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Plotlyve.Collaboration` context.
  """

  @doc """
  Generate a share.
  """
  def share_fixture(attrs \\ %{}) do
    {:ok, share} =
      attrs
      |> Enum.into(%{
        data_clip_id: "some data_clip_id",
        user_id: "some user_id"
      })
      |> Plotlyve.Collaboration.create_share()

    share
  end
end
