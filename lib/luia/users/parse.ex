defmodule Luia.Users.Parse do
  def run_all(list) do
    Stream.map(list, fn line ->
      line
      |> String.trim()
      |> String.split(",")
      |> case do
        [name, email, age] -> %{name: name, email: email, age: String.to_integer(age), inserted_by: to_string(Node.self())}
        unknown_format -> raise "Unknown format: #{inspect(unknown_format)}"
      end
    end)
  end
end
