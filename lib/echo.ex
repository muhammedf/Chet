defmodule EchoProtocol do
  @behaviour :ranch_protocol

  def start_link(_ref, socket, _transport, _protocolOptions) do
    Task.start_link(fn -> echo(socket) end)
  end

  defp echo(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, msg} ->
        :gen_tcp.send(socket, msg)
        echo(socket)
      _ -> nil
    end
  end

end
