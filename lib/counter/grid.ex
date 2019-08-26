defmodule Counter.Grid do
  use GenServer
	alias Counter.Pixels
	alias CounterWeb.Endpoint

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_state(), do: GenServer.call( __MODULE__, :get_state)
	def update_from_view(pixel), do: GenServer.cast( __MODULE__, {:update, pixel} )

  defp loop(), do: send self(), :loop

  def init(_) do
		grid = Pixels.get_init_state()
		loop()
		{:ok, {:grid, grid} }
	end

  def handle_info(:loop, {:grid, grid}) do
    :timer.sleep 1000
		next_grid = Pixels.next_state(grid)
		_broadcast = Endpoint.broadcast("grid", "update_grid", %{grid: next_grid})
    loop()
    {:noreply, {:grid, next_grid}}
  end

  def handle_call(:get_state, _state, {:grid, grid} ) do
		{:reply, {:grid, grid}, {:grid, grid}}
  end

  def handle_cast({:update, pixel_id}, {:grid, grid}) do
    grid_updated = Map.put(grid, pixel_id, %{class: "pixel_updated", id: pixel_id})
		_broadcast = Endpoint.broadcast("grid", "update_grid", %{grid: grid_updated})
    {:noreply, {:grid, grid_updated}}
  end

end
