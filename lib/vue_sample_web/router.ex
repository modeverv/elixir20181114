defmodule VueSampleWeb.Router do
  use VueSampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
#    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VueSampleWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController, except: [:new,:edit]
		resources "/bosts", BostController
  end

# 	scope "/api/v1", VueSampleWeb do
# 		pipe_through :api
# 		post "/sign_in", SessionController, :sign_in
# 		get "/logout", SessionController, :logout
# 		post "/users", UserController, :create
# 		resources "/users", UserController, except: [:create, :new, :edit]
# 	end


	scope "/api" do
		pipe_through :api
		scope "/v1",VueSampleWeb do
			post "/sign_in", SessionController, :sign_in
			get "/logout", SessionController, :logout
			post "/users", UserController, :create
			# ここにAuthenticated!的なこと書くと良さそう
			resources "/users", UserController, except: [:create, :new, :edit]
		end
		forward "/graphql", Absinthe.Plug.GraphQL, schema: VueSampleWeb.Schema
		forward "/", Absinthe.Plug, schema: VueSampleWeb.Schema
	end

  # Other scopes may use custom stacks.
  # scope "/api", VueSampleWeb do
  #   pipe_through :api
  # end
end
