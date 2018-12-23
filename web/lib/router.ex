defmodule Web.Router do
  use Plug.Router

  require Logger

  plug(:match)
  plug(:dispatch)

  get "/boids" do
    current_state = Web.Boids.get_boids()
    conn
    |> put_resp_content_type("application/json")
    |> put_status(200)
    |> send_resp(200, Jason.encode!(current_state))
  end

  match _ do
    send_resp(conn, 404, "Not found.")
  end
end
