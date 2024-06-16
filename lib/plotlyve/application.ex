defmodule Plotlyve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PlotlyveWeb.Telemetry,
      Plotlyve.Repo,
      {DNSCluster, query: Application.get_env(:plotlyve, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Plotlyve.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Plotlyve.Finch},
      # Start a worker by calling: Plotlyve.Worker.start_link(arg)
      # {Plotlyve.Worker, arg},
      # Start to serve requests, typically the last entry
      PlotlyveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plotlyve.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PlotlyveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
