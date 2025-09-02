defmodule Luia.Schemas.Process do
  use Ecto.Schema

  import Ecto.Changeset

  schema "process" do
    field :path, :string
    field :status, Ecto.Enum, values: [:inserted, :processing, :failed, :success]
    field :parent_node, :string

    timestamps()
  end

  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, [:path])
    |> put_change(:status, :inserted)
    |> put_change(:parent_node, to_string(Node.self()))
  end
end
