defmodule CounterWeb.ToyLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h2><%= @msg %></h2>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket) do
      CounterWeb.Endpoint.subscribe("toy_socket")
    end
    {:ok, assign(socket, :msg, "Saludos Perros")}
  end

  def handle_info(%{event: "new_message", payload: %{ msg: msg}}, socket) do
    IO.puts "\n\n ** Tocando Socket **  \n\n"
    {:noreply, assign(socket, :msg, msg)}
  end

  ##### Broadcast
  #CounterWeb.Endpoint.broadcast("toy_socket", "new_message", %{ msg: "Me ves?"})

end
