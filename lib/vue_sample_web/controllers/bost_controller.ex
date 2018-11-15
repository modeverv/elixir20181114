defmodule VueSampleWeb.BostController do
  use VueSampleWeb, :controller

  alias VueSample.Content
  alias VueSample.Content.Bost

  def index(conn, _params) do
    bosts = Content.list_bosts()
    render(conn, "index.html", bosts: bosts)
  end

  def new(conn, _params) do
    changeset = Content.change_bost(%Bost{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bost" => bost_params}) do
    case Content.create_bost(bost_params) do
      {:ok, bost} ->
        conn
        |> put_flash(:info, "Bost created successfully.")
        |> redirect(to: Routes.bost_path(conn, :show, bost))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bost = Content.get_bost!(id)
    render(conn, "show.html", bost: bost)
  end

  def edit(conn, %{"id" => id}) do
    bost = Content.get_bost!(id)
    changeset = Content.change_bost(bost)
    render(conn, "edit.html", bost: bost, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bost" => bost_params}) do
    bost = Content.get_bost!(id)

    case Content.update_bost(bost, bost_params) do
      {:ok, bost} ->
        conn
        |> put_flash(:info, "Bost updated successfully.")
        |> redirect(to: Routes.bost_path(conn, :show, bost))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bost: bost, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bost = Content.get_bost!(id)
    {:ok, _bost} = Content.delete_bost(bost)

    conn
    |> put_flash(:info, "Bost deleted successfully.")
    |> redirect(to: Routes.bost_path(conn, :index))
  end
end
