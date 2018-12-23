defmodule Web.Boids do
  use GenServer

  @derive Jason.Encoder
  defstruct [:x, :y, :velx, :vely]

  ## GenServer API
  def init(_state) do
    {:ok, boids} = Boids.start_link()
    {:ok, boids}
  end

  def handle_call(:fetch_all, _from, boids) do
    positions =
      Boids.get_all(boids)
      |> Enum.map(fn {x, y, {x_vel, y_vel}} ->
        %Web.Boids{x: x, y: y, velx: x_vel, vely: y_vel}
      end)

    {:reply, positions, boids}
  end

  # Client API

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def get_boids(), do: GenServer.call(__MODULE__, :fetch_all)
end
