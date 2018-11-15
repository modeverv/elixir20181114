defmodule VueSampleWeb.SessionView do
  use VueSampleWeb, :view

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{"token": jwt}
  end

  def render("error.json", %{message: msg}) do
    %{"error": msg}
  end

  def render("logout.json", %{message: msg}) do
    %{"ok": msg}
  end
end
