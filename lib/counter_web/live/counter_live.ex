defmodule CounterWeb.CounterLive do

  use Phoenix.LiveView
  alias CounterWeb.CounterView

  def render(assigns) do
    CounterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    pixels = get_pixels()
    socket =
    socket
      |> assign(:val, 10)
      |> assign(:pixels, pixels)
    {:ok, socket}
  end

  def get_pixels do
    pixels = for index <- 1..1000, do: %{ id: "pixel_#{index}", class: "pixel" }
    pixels
    |> Enum.map(fn element -> {element.id, element} end)
    |> Map.new()
  end

  def handle_event("inc", _, socket) do
      {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
      {:noreply, update(socket, :val, &(&1 - 1))}
  end

  def handle_event("change", pixel_id, socket) do
    pixels = get_pixels()
    pixels= Map.put(pixels, pixel_id, %{class: "pixel_updated", id: pixel_id})
    socket =
      socket
      |> assign(:pixels, pixels)
    {:noreply, socket}
  end

end
