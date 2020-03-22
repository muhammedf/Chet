defmodule UserStorage do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get_user(name) do
    Agent.get(__MODULE__, fn data -> Map.get(data, name) end)
  end

  def delete_user(name) do
    Agent.update(__MODULE__, fn data -> Map.delete(data, name) end)
  end

  def set_user(name, socket) do
    Agent.update(__MODULE__, fn data -> Map.update(data |>IO.inspect, name |> IO.inspect, socket, fn _ -> socket end) end)
  end

end
