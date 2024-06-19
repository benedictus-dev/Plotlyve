defmodule Plotlyve.CollaborationTest do
  use Plotlyve.DataCase

  alias Plotlyve.Collaboration

  describe "shares" do
    alias Plotlyve.Collaboration.Share

    import Plotlyve.CollaborationFixtures

    @invalid_attrs %{data_clip_id: nil, user_id: nil}

    test "list_shares/0 returns all shares" do
      share = share_fixture()
      assert Collaboration.list_shares() == [share]
    end

    test "get_share!/1 returns the share with given id" do
      share = share_fixture()
      assert Collaboration.get_share!(share.id) == share
    end

    test "create_share/1 with valid data creates a share" do
      valid_attrs = %{data_clip_id: "some data_clip_id", user_id: "some user_id"}

      assert {:ok, %Share{} = share} = Collaboration.create_share(valid_attrs)
      assert share.data_clip_id == "some data_clip_id"
      assert share.user_id == "some user_id"
    end

    test "create_share/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collaboration.create_share(@invalid_attrs)
    end

    test "update_share/2 with valid data updates the share" do
      share = share_fixture()
      update_attrs = %{data_clip_id: "some updated data_clip_id", user_id: "some updated user_id"}

      assert {:ok, %Share{} = share} = Collaboration.update_share(share, update_attrs)
      assert share.data_clip_id == "some updated data_clip_id"
      assert share.user_id == "some updated user_id"
    end

    test "update_share/2 with invalid data returns error changeset" do
      share = share_fixture()
      assert {:error, %Ecto.Changeset{}} = Collaboration.update_share(share, @invalid_attrs)
      assert share == Collaboration.get_share!(share.id)
    end

    test "delete_share/1 deletes the share" do
      share = share_fixture()
      assert {:ok, %Share{}} = Collaboration.delete_share(share)
      assert_raise Ecto.NoResultsError, fn -> Collaboration.get_share!(share.id) end
    end

    test "change_share/1 returns a share changeset" do
      share = share_fixture()
      assert %Ecto.Changeset{} = Collaboration.change_share(share)
    end
  end
end
