defmodule Counter.Grid do
  use GenServer
	alias Counter.Pixels

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  defp loop(), do: send self(), :loop

  def init(_) do
		grid = Pixels.get_init_state()
		loop()
		{:ok, {:grid, grid} }
	end

  def handle_info(:loop, {:grid, grid}) do
    :timer.sleep 1000
		next_grid = Pixels.next_state(grid)
		IO.inspect grid
    loop()
    {:noreply, {:grid, next_grid}}
  end


end
