defmodule Chet do
  use Application
  @moduledoc """
  Documentation for Chet.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Chet.hello()
      :world

  """
  def hello do
    :world
  end

  def start(_type, _args) do
    Acceptor.start(22222)
    children = [
      Connections
    ]
    opts = [strategy: :one_for_one, name: MainSupervisor]
    Supervisor.start_link(children, opts)
  end
end
