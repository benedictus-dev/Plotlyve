defmodule PlotlyveWeb.ErrorJSONTest do
  use PlotlyveWeb.ConnCase, async: true

  test "renders 404" do
    assert PlotlyveWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert PlotlyveWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
