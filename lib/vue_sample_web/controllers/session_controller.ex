defmodule VueSampleWeb.SessionController do
  use VueSampleWeb, :controller

  alias VueSample.Users.User
  alias VueSample.Guardian
	alias VueSample.AuthTokens

  def login(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case User.find_and_confirm_password(email, password) do
      {:ok, user} ->
				conn |> login_reply({:ok, user})
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
	end

  defp login_reply(conn, {:ok, user}) do
    {:ok, access_token, access_claims, refresh_token, _refresh_claims} = create_token(user)
    response = %{
      access_token: access_token,
      refresh_token: refresh_token,
      expires_in: access_claims["exp"]
    }
    render(conn, "login.json", response: response)
  end

  defp create_token(user) do
#    {:ok, access_token, access_claims} = Guardian.encode_and_sign(user, %{}, [token_type: "refresh", ttl: {100, :second}])
    {:ok, access_token, access_claims} = Guardian.encode_and_sign(user, %{}, [token_type: "access", ttl: {100, :second}])
    {:ok, refresh_token, refresh_claims} = Guardian.encode_and_sign(user, %{access_token: access_token}, [token_type: "refresh", ttl: {1200, :second}])
    {:ok, _a_token} = AuthTokens.after_encode_and_sign(user, access_claims, access_token)
    {:ok, _r_token} = AuthTokens.after_encode_and_sign(user, refresh_claims, refresh_token)
    {:ok, access_token, access_claims, refresh_token, refresh_claims}
  end

  def logout(conn, %{"refresh_token" => refresh_token}) do
    logout_reply(conn, confirm_token(refresh_token), refresh_token)
  end

  defp logout_reply(conn, {:ok, claims},refresh_token) do
    case AuthTokens.on_revoke(claims, refresh_token) do
      {:ok, _} ->
        with {:ok, access_claims} <- confirm_token(claims["access_token"]) do
					IO.inspect("reflesh_token revoke OK.")
					IO.inspect(claims)
          AuthTokens.on_revoke(access_claims, claims["access_token"])
					IO.inspect("access_token revoke OK.")
        end
        render(conn, "logout.json", message: "logout OK")
      {:error, _} -> logout_reply(conn, {:error, :revoke_error}, refresh_token)
    end

  end

  defp logout_reply(conn, {:error, _}, _) do
    conn
    |> put_status(:bad_request)
    |> render("error.json", message: "Could not logout")
  end

  @doc """
  Confirm token
  """
  def confirm_token(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        AuthTokens.on_verify(claims, token)
      _ -> {:error, :not_decode_and_verify}
    end
  end

  def refresh_token(conn, %{"refresh_token"=> refresh_token}) do
    refresh_token_reply(conn, confirm_token(refresh_token), refresh_token)
  end

  defp refresh_token_reply(conn, {:ok, claims}, refresh_token) do
    user = User.get_user!(claims["sub"])
    AuthTokens.on_revoke(claims, refresh_token)
    with {:ok, access_claims} <- confirm_token(claims["access_token"]) do
      AuthTokens.on_revoke(access_claims, claims["access_token"])
    end
    login_reply(conn, {:ok, user})
  end

  defp refresh_token_reply(conn, {:error, _}, _) do
    conn
    |> put_status(:bad_request)
    |> render("error.json", message: "refresh token is expired. please re login" )
  end





end
