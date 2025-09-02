defmodule Luia.Workers.ParallelWorker do
  use Oban.Worker

  alias Luia.Schemas.Process

  def enqueue(%Process{} = process) do
    %{process_id: process.id}
    |> __MODULE__.new()
    |> Oban.insert()
  end

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"process_id" => process_id}}) do
    process = Luia.Repo.get!(Process, process_id)

    nodes = [Node.self() | Node.list()]

    process.path
    |> File.stream!()
    |> Stream.chunk_every(30)
    |> Stream.with_index()
    |> Enum.map(fn {chunk, idx} ->
      node = Enum.at(nodes, rem(idx, length(nodes)))

      Task.Supervisor.async_nolink(Luia.TaskSupervisor, fn ->
        {node, :erpc.cast(node, Luia.Users.ProcessFile, :run, [chunk, idx])}
      end)
    end)

    :ok
  end
end
