# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cryptex,
  ecto_repos: [Cryptex.Repo]

# Configures the endpoint
config :cryptex, CryptexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n4QaApo/6MsFTswqVXBUzOVjDvLMXo8aAj0CNy8pSm7LksfBuHtLhAaWiMIEioek",
  render_errors: [view: CryptexWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Cryptex.PubSub,
  live_view: [signing_salt: "pNHen29m"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cryptex, Cryptex.Requests, binance_data_api_base_url: "wss://stream.binance.com:9443/ws"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
