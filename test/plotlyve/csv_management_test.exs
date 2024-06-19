defmodule Plotlyve.CsvManagementTest do
  use Plotlyve.DataCase

  alias Plotlyve.CsvManagement

  describe "csv_metadata" do
    alias Plotlyve.CsvManagement.CsvMetadata

    import Plotlyve.CsvManagementFixtures

    @invalid_attrs %{filename: nil, columns: nil}

    test "list_csv_metadata/0 returns all csv_metadata" do
      csv_metadata = csv_metadata_fixture()
      assert CsvManagement.list_csv_metadata() == [csv_metadata]
    end

    test "get_csv_metadata!/1 returns the csv_metadata with given id" do
      csv_metadata = csv_metadata_fixture()
      assert CsvManagement.get_csv_metadata!(csv_metadata.id) == csv_metadata
    end

    test "create_csv_metadata/1 with valid data creates a csv_metadata" do
      valid_attrs = %{filename: "some filename", columns: ["option1", "option2"]}

      assert {:ok, %CsvMetadata{} = csv_metadata} = CsvManagement.create_csv_metadata(valid_attrs)
      assert csv_metadata.filename == "some filename"
      assert csv_metadata.columns == ["option1", "option2"]
    end

    test "create_csv_metadata/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CsvManagement.create_csv_metadata(@invalid_attrs)
    end

    test "update_csv_metadata/2 with valid data updates the csv_metadata" do
      csv_metadata = csv_metadata_fixture()
      update_attrs = %{filename: "some updated filename", columns: ["option1"]}

      assert {:ok, %CsvMetadata{} = csv_metadata} = CsvManagement.update_csv_metadata(csv_metadata, update_attrs)
      assert csv_metadata.filename == "some updated filename"
      assert csv_metadata.columns == ["option1"]
    end

    test "update_csv_metadata/2 with invalid data returns error changeset" do
      csv_metadata = csv_metadata_fixture()
      assert {:error, %Ecto.Changeset{}} = CsvManagement.update_csv_metadata(csv_metadata, @invalid_attrs)
      assert csv_metadata == CsvManagement.get_csv_metadata!(csv_metadata.id)
    end

    test "delete_csv_metadata/1 deletes the csv_metadata" do
      csv_metadata = csv_metadata_fixture()
      assert {:ok, %CsvMetadata{}} = CsvManagement.delete_csv_metadata(csv_metadata)
      assert_raise Ecto.NoResultsError, fn -> CsvManagement.get_csv_metadata!(csv_metadata.id) end
    end

    test "change_csv_metadata/1 returns a csv_metadata changeset" do
      csv_metadata = csv_metadata_fixture()
      assert %Ecto.Changeset{} = CsvManagement.change_csv_metadata(csv_metadata)
    end
  end

  describe "csv_data" do
    alias Plotlyve.CsvManagement.CsvData

    import Plotlyve.CsvManagementFixtures

    @invalid_attrs %{data: nil}

    test "list_csv_data/0 returns all csv_data" do
      csv_data = csv_data_fixture()
      assert CsvManagement.list_csv_data() == [csv_data]
    end

    test "get_csv_data!/1 returns the csv_data with given id" do
      csv_data = csv_data_fixture()
      assert CsvManagement.get_csv_data!(csv_data.id) == csv_data
    end

    test "create_csv_data/1 with valid data creates a csv_data" do
      valid_attrs = %{data: %{}}

      assert {:ok, %CsvData{} = csv_data} = CsvManagement.create_csv_data(valid_attrs)
      assert csv_data.data == %{}
    end

    test "create_csv_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CsvManagement.create_csv_data(@invalid_attrs)
    end

    test "update_csv_data/2 with valid data updates the csv_data" do
      csv_data = csv_data_fixture()
      update_attrs = %{data: %{}}

      assert {:ok, %CsvData{} = csv_data} = CsvManagement.update_csv_data(csv_data, update_attrs)
      assert csv_data.data == %{}
    end

    test "update_csv_data/2 with invalid data returns error changeset" do
      csv_data = csv_data_fixture()
      assert {:error, %Ecto.Changeset{}} = CsvManagement.update_csv_data(csv_data, @invalid_attrs)
      assert csv_data == CsvManagement.get_csv_data!(csv_data.id)
    end

    test "delete_csv_data/1 deletes the csv_data" do
      csv_data = csv_data_fixture()
      assert {:ok, %CsvData{}} = CsvManagement.delete_csv_data(csv_data)
      assert_raise Ecto.NoResultsError, fn -> CsvManagement.get_csv_data!(csv_data.id) end
    end

    test "change_csv_data/1 returns a csv_data changeset" do
      csv_data = csv_data_fixture()
      assert %Ecto.Changeset{} = CsvManagement.change_csv_data(csv_data)
    end
  end

  describe "csv_column_data" do
    alias Plotlyve.CsvManagement.CsvColumnData

    import Plotlyve.CsvManagementFixtures

    @invalid_attrs %{values: nil, column_name: nil}

    test "list_csv_column_data/0 returns all csv_column_data" do
      csv_column_data = csv_column_data_fixture()
      assert CsvManagement.list_csv_column_data() == [csv_column_data]
    end

    test "get_csv_column_data!/1 returns the csv_column_data with given id" do
      csv_column_data = csv_column_data_fixture()
      assert CsvManagement.get_csv_column_data!(csv_column_data.id) == csv_column_data
    end

    test "create_csv_column_data/1 with valid data creates a csv_column_data" do
      valid_attrs = %{values: ["option1", "option2"], column_name: "some column_name"}

      assert {:ok, %CsvColumnData{} = csv_column_data} = CsvManagement.create_csv_column_data(valid_attrs)
      assert csv_column_data.values == ["option1", "option2"]
      assert csv_column_data.column_name == "some column_name"
    end

    test "create_csv_column_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CsvManagement.create_csv_column_data(@invalid_attrs)
    end

    test "update_csv_column_data/2 with valid data updates the csv_column_data" do
      csv_column_data = csv_column_data_fixture()
      update_attrs = %{values: ["option1"], column_name: "some updated column_name"}

      assert {:ok, %CsvColumnData{} = csv_column_data} = CsvManagement.update_csv_column_data(csv_column_data, update_attrs)
      assert csv_column_data.values == ["option1"]
      assert csv_column_data.column_name == "some updated column_name"
    end

    test "update_csv_column_data/2 with invalid data returns error changeset" do
      csv_column_data = csv_column_data_fixture()
      assert {:error, %Ecto.Changeset{}} = CsvManagement.update_csv_column_data(csv_column_data, @invalid_attrs)
      assert csv_column_data == CsvManagement.get_csv_column_data!(csv_column_data.id)
    end

    test "delete_csv_column_data/1 deletes the csv_column_data" do
      csv_column_data = csv_column_data_fixture()
      assert {:ok, %CsvColumnData{}} = CsvManagement.delete_csv_column_data(csv_column_data)
      assert_raise Ecto.NoResultsError, fn -> CsvManagement.get_csv_column_data!(csv_column_data.id) end
    end

    test "change_csv_column_data/1 returns a csv_column_data changeset" do
      csv_column_data = csv_column_data_fixture()
      assert %Ecto.Changeset{} = CsvManagement.change_csv_column_data(csv_column_data)
    end
  end

  describe "dataclips" do
    alias Plotlyve.CsvManagement.Dataclip

    import Plotlyve.CsvManagementFixtures

    @invalid_attrs %{shared_with: nil, dataclip: nil}

    test "list_dataclips/0 returns all dataclips" do
      dataclip = dataclip_fixture()
      assert CsvManagement.list_dataclips() == [dataclip]
    end

    test "get_dataclip!/1 returns the dataclip with given id" do
      dataclip = dataclip_fixture()
      assert CsvManagement.get_dataclip!(dataclip.id) == dataclip
    end

    test "create_dataclip/1 with valid data creates a dataclip" do
      valid_attrs = %{shared_with: "some shared_with", dataclip: %{}}

      assert {:ok, %Dataclip{} = dataclip} = CsvManagement.create_dataclip(valid_attrs)
      assert dataclip.shared_with == "some shared_with"
      assert dataclip.dataclip == %{}
    end

    test "create_dataclip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CsvManagement.create_dataclip(@invalid_attrs)
    end

    test "update_dataclip/2 with valid data updates the dataclip" do
      dataclip = dataclip_fixture()
      update_attrs = %{shared_with: "some updated shared_with", dataclip: %{}}

      assert {:ok, %Dataclip{} = dataclip} = CsvManagement.update_dataclip(dataclip, update_attrs)
      assert dataclip.shared_with == "some updated shared_with"
      assert dataclip.dataclip == %{}
    end

    test "update_dataclip/2 with invalid data returns error changeset" do
      dataclip = dataclip_fixture()
      assert {:error, %Ecto.Changeset{}} = CsvManagement.update_dataclip(dataclip, @invalid_attrs)
      assert dataclip == CsvManagement.get_dataclip!(dataclip.id)
    end

    test "delete_dataclip/1 deletes the dataclip" do
      dataclip = dataclip_fixture()
      assert {:ok, %Dataclip{}} = CsvManagement.delete_dataclip(dataclip)
      assert_raise Ecto.NoResultsError, fn -> CsvManagement.get_dataclip!(dataclip.id) end
    end

    test "change_dataclip/1 returns a dataclip changeset" do
      dataclip = dataclip_fixture()
      assert %Ecto.Changeset{} = CsvManagement.change_dataclip(dataclip)
    end
  end
end
