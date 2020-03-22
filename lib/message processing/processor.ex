defmodule LineProcessor do

  def process(text, state) do
    case text do
      "ping\n" -> Client.send_message("pong\n", state.socket)
      "mynameis " <> name ->
        name = String.trim(name)
        Client.send_message("ok, your name is " <> name <> "\n", state.socket)
      _ -> Client.send_message("unknown command\n", state.socket)
    end
  end

end
