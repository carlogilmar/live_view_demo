defmodule CounterWeb.CounterLive do

  use Phoenix.LiveView
  alias CounterWeb.CounterView
	alias Counter.Pixels
	alias CounterWeb.Endpoint

  def render(assigns) do
    CounterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
		Endpoint.subscribe("grid")
    pixels = Pixels.get_init_state()
    socket =
    socket
      |> assign(:pixels, pixels)
    {:ok, socket}
  end

  def handle_event("change", pixel_id, socket) do
		_ = Counter.Grid.update_from_view(pixel_id)
    {:noreply, socket}
  end

  def handle_info(%{event: "update_grid", payload: %{grid: grid}}, socket) do
    socket =
      socket
      |> assign(:pixels, grid)
    {:noreply, socket}
  end

end
