defmodule Luia.Users.ProcessFile do
  require Logger

  alias Luia.Users.Parse
  alias Luia.Users.InsertAll

  def run(chunk, index) do
    Logger.info("""
    [#{__MODULE__}] Start processing chunk #{index}
    Node: #{inspect(Node.self())}
    """)

    chunk
    |> Parse.run_all()
    |> InsertAll.execute()
  end
end
