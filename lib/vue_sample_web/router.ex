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

	pipeline :authenticated do    # (1)3行追加
    plug VueSample.Guardian.AuthPipeline
  end

  scope "/", VueSampleWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController, except: [:new,:edit]
		resources "/bosts", BostController
		resources "/users", UserController

		resources "/hsessions", HsessionController, only: [:create]
    get "/login", HsessionController, :new     # 追加
    get "/logout", HsessionController, :delete # 追加
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
			post "/login", SessionController, :login
			post "/users", UserController, :create
			post "/logout", SessionController, :logout
			post "/refresh_token", SessionController, :refresh_token
			# ここにAuthenticated!的なこと書くと良さそう
			pipe_through :authenticated
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
