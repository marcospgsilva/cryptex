defmodule Cryptex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Cryptex.Repo,
      # Start the Telemetry supervisor
      CryptexWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cryptex.PubSub},
      # Start the Endpoint (http/https)
      CryptexWeb.Endpoint,
      Cryptex.DynamicSupervisor
      # Start a worker by calling: Cryptex.Worker.start_link(arg)
      # {Cryptex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cryptex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CryptexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
