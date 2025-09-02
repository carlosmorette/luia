defmodule Luia.Repo.Migrations.CreateProcessTable do
  use Ecto.Migration

  def change do
    create table(:process) do
      add :path, :string
      add :status, :string
      add :parent_node, :string

      timestamps()
    end
  end
end
