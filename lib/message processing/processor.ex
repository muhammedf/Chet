defmodule LineProcessor do

  def process(text, state, pid) do
    case text do
      "ping\n" -> Client.send_message("pong\n", state.socket)
      "mynameis " <> name ->
        name = String.trim(name)
        send pid, {:update_name, name}
        Client.send_message("ok, your name is " <> name <> "\n", state.socket)
      "whatismyname\n" -> Client.send_message("hellooo, you are " <> state.name <> "\n", state.socket)
      _ -> Client.send_message("unknown command\n", state.socket)
    end
  end

end
