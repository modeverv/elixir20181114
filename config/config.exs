# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vue_sample,
  ecto_repos: [VueSample.Repo]

# Configures the endpoint
config :vue_sample, VueSampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EbKyVKWFUz6AXXe1+zfSLElQeHuTzYAkDzmoXiee6q8mJofds2IOYSqlDvm2oO+Z",
  render_errors: [view: VueSampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VueSample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :guardian, Guardian.DB,
  repo: VueSample.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60 # default: 60 minutes

config :vue_sample, VueSample.Guardian,
  issuer: "vue_sample",
  secret_key: "0tjYImjIH1r2YEXgEFHeYq7p7iTjsX7oAXnblqGrGT9J/kj5LAE9Yjj6Ads1ZiN7"
