defmodule Backend.Guardian.AuthErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    with {:ok, body} <- Jason.encode(%{error: to_string(type)}) do
      conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, body)
    end
  end
end
