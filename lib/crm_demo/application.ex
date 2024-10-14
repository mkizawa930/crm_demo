defmodule CrmDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CrmDemoWeb.Telemetry,
      CrmDemo.Repo,
      {DNSCluster, query: Application.get_env(:crm_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CrmDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CrmDemo.Finch},
      # Start a worker by calling: CrmDemo.Worker.start_link(arg)
      # {CrmDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      CrmDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CrmDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CrmDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
