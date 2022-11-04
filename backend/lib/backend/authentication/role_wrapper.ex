defmodule Backend.Guardian.RoleWrapper do

  alias BackendWeb.UserController
  alias Backend.User

  def check_current_user(conn, user_id) do
    current_user = Guardian.Plug.current_resource(conn)
    case current_user.id == user_id or current_user.role == "admin" do
      false -> {:error, :unauthorized}
      true -> {:ok, current_user}
    end
  end

  def check_admin(conn) do
    current_user = Guardian.Plug.current_resource(conn)
    case current_user.role == "admin" do
      false -> {:error, :unauthorized}
      true -> {:ok, current_user}
    end
  end
end
