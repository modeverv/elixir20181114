defmodule VueSampleWeb.SessionController do
  use VueSampleWeb, :controller

  alias VueSample.Users.User

  def sign_in(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case User.find_and_confirm_password(email, password) do
      {:ok, user} ->
         {:ok, jwt, _full_claims} =  VueSample.Guardian.encode_and_sign(user)
         # {:ok, claims} = Phx13Gdn10.Guardian.decode_and_verify(jwt)
         # IO.inspect(claims)
         conn
         |> render("sign_in.json", user: user, jwt: jwt)
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end

	def logout(conn, %{}) do
    conn
    |> VueSample.Guardian.Plug.sign_out
		|> put_status(200)
    |> render("logout.json", message: "logged out")
  end
end
