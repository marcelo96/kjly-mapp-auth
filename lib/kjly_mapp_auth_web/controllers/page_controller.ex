defmodule KjlyMappAuthWeb.PageController do
  use KjlyMappAuthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
