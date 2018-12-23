defmodule Web.Server do
  use Supervisor
  require Logger

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Web.Router, options: [port: cowboy_port()]}
    ]

    opts = [strategy: :one_for_one, name: Web.Supervisor]
    Supervisor.init(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:web, :cowboy_port, 8080)
end
