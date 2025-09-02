defmodule Luia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LuiaWeb.Telemetry,
      Luia.Repo,
      {DNSCluster, query: Application.get_env(:luia, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Luia.PubSub},
      {Finch, name: Luia.Finch},
      LuiaWeb.Endpoint,
      {Oban, Application.fetch_env!(:luia, Oban)},
      {Task.Supervisor, name: Luia.TaskSupervisor}
    ]

    :ok = create_uploads_directory()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Luia.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LuiaWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp create_uploads_directory() do
    priv_dir = :code.priv_dir(:luia)

    priv_dir
    |> Path.join("uploads")
    |> File.mkdir_p!()
  end
end
