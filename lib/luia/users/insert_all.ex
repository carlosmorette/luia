defmodule Luia.Users.InsertAll do
  def execute(stream) do
    users = Enum.to_list(stream)
    Luia.Repo.insert_all(Luia.Users.User, users)
  end
end
