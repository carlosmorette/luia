defmodule LuiaWeb.FileController do
  use LuiaWeb, :controller

  def process(conn, _params) do
    :ok = Luia.CreateProcess.run(conn)
    send_resp(conn, :ok, "")
  end
end
