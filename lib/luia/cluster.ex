defmodule Luia.Cluster do
  def run_on_all_nodes_async(fun) do
    Enum.map([Node.self() | Node.list()], fn node ->
      Task.Supervisor.async_nolink(Luia.TaskSupervisor, fn ->
        {node, :erpc.cast(node, :erlang, :apply, [fun, []])}
      end)
    end)
  end
end
