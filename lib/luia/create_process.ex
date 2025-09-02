defmodule Luia.CreateProcess do
  alias Luia.Schemas.Process
  alias Luia.Repo
  alias Luia.Workers.ParallelWorker

  def run(conn) do
    filename = filename()
    case File.open(filename, [:append], fn file ->  stream_body(conn, file) end) do
      {:ok, :ok} ->
        Process.create_changeset(%{path: filename})
        |> Repo.insert!()
        |> ParallelWorker.enqueue()

        :ok

      _ -> :error
    end
  end

  defp stream_body(conn, file) do
    case Plug.Conn.read_body(conn, length: 8_000_000) do
      {:ok, chunk, _conn} ->
        IO.binwrite(file, chunk)

      {:more, chunk, conn} ->
        IO.binwrite(file, chunk)
        stream_body(conn, file)
    end
  end

  defp filename do
    now = DateTime.to_unix(DateTime.utc_now())

    :code.priv_dir(:luia)
    |> Path.join("uploads")
    |> Path.join(to_string(now))
  end
end
