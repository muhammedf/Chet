defmodule Acceptor do

  def accept(port) do
    case :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true]) do
      {:ok, socket} ->
        {:ok, pid} = Task.start_link( fn  -> accept_loop(socket) end)
        Process.register(pid, Acceptor)
        {:ok, pid}
      _ -> nil
    end
  end

  defp accept_loop(socket) do
    case :gen_tcp.accept(socket) do
      {:ok, client} ->
        Connections.add_connection(client)
        accept_loop(socket)
      _ -> nil
    end
  end

  def child_spec(_arg) do
    %{id: Acceptor,
      start: {Acceptor, :accept, [22222]}
    }
  end

end
