defmodule VueSampleWeb.BostControllerTest do
  use VueSampleWeb.ConnCase

  alias VueSample.Content

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:bost) do
    {:ok, bost} = Content.create_bost(@create_attrs)
    bost
  end

  describe "index" do
    test "lists all bosts", %{conn: conn} do
      conn = get(conn, Routes.bost_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Bosts"
    end
  end

  describe "new bost" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bost_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bost"
    end
  end

  describe "create bost" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bost_path(conn, :create), bost: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bost_path(conn, :show, id)

      conn = get(conn, Routes.bost_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bost"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bost_path(conn, :create), bost: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bost"
    end
  end

  describe "edit bost" do
    setup [:create_bost]

    test "renders form for editing chosen bost", %{conn: conn, bost: bost} do
      conn = get(conn, Routes.bost_path(conn, :edit, bost))
      assert html_response(conn, 200) =~ "Edit Bost"
    end
  end

  describe "update bost" do
    setup [:create_bost]

    test "redirects when data is valid", %{conn: conn, bost: bost} do
      conn = put(conn, Routes.bost_path(conn, :update, bost), bost: @update_attrs)
      assert redirected_to(conn) == Routes.bost_path(conn, :show, bost)

      conn = get(conn, Routes.bost_path(conn, :show, bost))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, bost: bost} do
      conn = put(conn, Routes.bost_path(conn, :update, bost), bost: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bost"
    end
  end

  describe "delete bost" do
    setup [:create_bost]

    test "deletes chosen bost", %{conn: conn, bost: bost} do
      conn = delete(conn, Routes.bost_path(conn, :delete, bost))
      assert redirected_to(conn) == Routes.bost_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bost_path(conn, :show, bost))
      end
    end
  end

  defp create_bost(_) do
    bost = fixture(:bost)
    {:ok, bost: bost}
  end
end
