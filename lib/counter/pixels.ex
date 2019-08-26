defmodule Counter.Pixels do

  def get_init_state do
    pixels = for index <- 1..500, do: %{ id: "pixel_#{index}", class: "pixel1" }
    pixels
    |> Enum.map(fn element -> {element.id, element} end)
    |> Map.new()
  end

  def next_state(pixels_grid) do
    for {pixel_id, %{class: _class, id: _pixel_id}} <- pixels_grid do
      next_class = Enum.random(1..5)
      {pixel_id, %{class: "pixel#{next_class}", id: pixel_id}}
    end
  end

end
