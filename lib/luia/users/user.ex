defmodule Luia.Users.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :age, :integer
    field :inserted_by, :string
  end
end
