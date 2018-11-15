defmodule VueSampleWeb.PostController do
  use VueSampleWeb, :controller

  alias VueSample.Api
  alias VueSample.Api.Post

  action_fallback VueSampleWeb.FallbackController

  def index(conn, _params) do
    posts = Api.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Api.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Api.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Api.get_post!(id)

    with {:ok, %Post{} = post} <- Api.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Api.get_post!(id)

    with {:ok, %Post{}} <- Api.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
