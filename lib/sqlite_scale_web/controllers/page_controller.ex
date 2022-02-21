defmodule SqliteScaleWeb.PageController do
  use SqliteScaleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
