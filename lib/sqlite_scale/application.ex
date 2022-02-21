defmodule SqliteScale.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SqliteScale.Repo,
      # Start the Telemetry supervisor
      SqliteScaleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SqliteScale.PubSub},
      # Start the Endpoint (http/https)
      SqliteScaleWeb.Endpoint
      # Start a worker by calling: SqliteScale.Worker.start_link(arg)
      # {SqliteScale.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SqliteScale.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SqliteScaleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
