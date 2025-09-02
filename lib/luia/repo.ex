defmodule Luia.Repo do
  use Ecto.Repo,
    otp_app: :luia,
    adapter: Ecto.Adapters.Postgres
end
