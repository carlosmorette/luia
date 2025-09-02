defmodule LuiaWeb.ErrorJSONTest do
  use LuiaWeb.ConnCase, async: true

  test "renders 404" do
    assert LuiaWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LuiaWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
