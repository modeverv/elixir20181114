defmodule VueSampleWeb.HsessionController do
  use VueSampleWeb, :controller

  alias VueSample.Users

  def new(conn, _) do
    current = get_session(conn, :user)  # (1) sessionから取得
    render(conn, "new.html", current: current)
  end

  def delete(conn, _) do
    conn
    |> delete_session(:user) # (2) sessionを削除
    |> put_flash(:info, "Logged out successfully!")
    |> redirect(to: "/")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    with user <- Users.get_user_by_email(email),
         {:ok, login_user} <- login(user, password)
    do
      conn
      |> put_flash(:info, "Logged in successfully!")
        # (3) sessionに保存
      |> put_session(:user, %{ id: login_user.id, name: login_user.name, email: login_user.email })
      |> redirect(to: "/")
    else
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid username/password!")
        |> render("new.html")
    end
  end

  def login(user, password) do
    ### 入力されたpasswordが保存されているハッシュ値に等しいかをチェック
    Comeonin.Bcrypt.check_pass(user, password)
  end
end
