defmodule LineProcessor do

  def process(text, state, pid) do
    case text do
      "ping\n" -> Client.send_message("pong\n", state.socket)
      "mynameis " <> name ->
        name = String.trim(name)
        case UserStorage.get_user(name) do
          nil ->
            send pid, {:update_name, name}
            Client.send_message("ok, your name is " <> name <> "\n", state.socket)
          _ ->
            Client.send_message("name already exists\n", state.socket)
        end
      "whatismyname\n" -> Client.send_message("hellooo, you are " <> state.name <> "\n", state.socket)
      "sendmsg " <> rest ->
        [to, msg] = rest |> String.split(" ", parts: 2)
        case UserStorage.get_user(to) do
          nil -> Client.send_message("user not found\n", state.socket)
          socket -> Client.send_message(msg, socket)
        end
      _ -> Client.send_message("unknown command\n", state.socket)
    end
  end

end
