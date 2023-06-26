defmodule MordrumApiServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MordrumApiServerWeb.Telemetry,
      # Start the Ecto repository
      MordrumApiServer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: MordrumApiServer.PubSub},
      # Start Finch
      {Finch, name: MordrumApiServer.Finch},
      # Start the Endpoint (http/https)
      MordrumApiServerWeb.Endpoint
      # Start a worker by calling: MordrumApiServer.Worker.start_link(arg)
      # {MordrumApiServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MordrumApiServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MordrumApiServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
