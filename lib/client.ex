defmodule Client do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(init_args) do
    socket = Map.get(init_args, :socket)
    :inet.setopts(socket, active: true)
    {:ok, %{socket: socket}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  def send_message(msg, socket) do
    :gen_tcp.send(socket, msg)
  end

end
