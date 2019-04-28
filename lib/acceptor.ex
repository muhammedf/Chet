defmodule Acceptor do
  @behaviour :ranch_protocol

  def start_link(_ref, socket, _transport, _protocolOptions) do
    Connections.add_connection(socket)
  end

  def start(port) do
    :ranch.start_listener(Acceptor, :ranch_tcp, [port: port], Acceptor, %{})
  end

end
