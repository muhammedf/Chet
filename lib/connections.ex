defmodule Connections do
  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_connection(con) do
    child_spec = %{
      id: Client,
      start: {Client, :start_link, [%{socket: con}]},
      type: :worker,
      restart: :temporary
    }
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, child_spec)
    :gen_tcp.controlling_process(con, pid)
    {:ok, pid}
  end
end
