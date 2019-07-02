defmodule CounterWeb.PicturesLive do
  use Phoenix.LiveView
  alias Phoenix.Socket.Broadcast


  def render(assigns) do
    ~L"""
    <h1> Message: <%= @msg %> </h1>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :msg, "Aca iniciando papa!!")}
  end

  def handle_event("send_message", _, socket) do
    {:noreply, update(socket, :msg, "eeey!!")}
  end

end
