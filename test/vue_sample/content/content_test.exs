defmodule VueSample.ContentTest do
  use VueSample.DataCase

  alias VueSample.Content

  describe "bosts" do
    alias VueSample.Content.Bost

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def bost_fixture(attrs \\ %{}) do
      {:ok, bost} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_bost()

      bost
    end

    test "list_bosts/0 returns all bosts" do
      bost = bost_fixture()
      assert Content.list_bosts() == [bost]
    end

    test "get_bost!/1 returns the bost with given id" do
      bost = bost_fixture()
      assert Content.get_bost!(bost.id) == bost
    end

    test "create_bost/1 with valid data creates a bost" do
      assert {:ok, %Bost{} = bost} = Content.create_bost(@valid_attrs)
      assert bost.body == "some body"
      assert bost.title == "some title"
    end

    test "create_bost/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_bost(@invalid_attrs)
    end

    test "update_bost/2 with valid data updates the bost" do
      bost = bost_fixture()
      assert {:ok, %Bost{} = bost} = Content.update_bost(bost, @update_attrs)
      assert bost.body == "some updated body"
      assert bost.title == "some updated title"
    end

    test "update_bost/2 with invalid data returns error changeset" do
      bost = bost_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_bost(bost, @invalid_attrs)
      assert bost == Content.get_bost!(bost.id)
    end

    test "delete_bost/1 deletes the bost" do
      bost = bost_fixture()
      assert {:ok, %Bost{}} = Content.delete_bost(bost)
      assert_raise Ecto.NoResultsError, fn -> Content.get_bost!(bost.id) end
    end

    test "change_bost/1 returns a bost changeset" do
      bost = bost_fixture()
      assert %Ecto.Changeset{} = Content.change_bost(bost)
    end
  end
end
