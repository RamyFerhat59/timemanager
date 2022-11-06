defmodule Backend.Guardian.RoleWrapper do

  # alias BackendWeb.UserController
  # alias Backend.User

  def check_current_user(conn, user_id) do
    current_user = Guardian.Plug.current_resource(conn)

    case current_user.id == check_id(user_id) or current_user.role == "admin" do
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

  # inside functions

  def check_id(user_id) do
    case is_bitstring(user_id) do
      true -> String.to_integer(user_id)
      false -> user_id
    end
  end
end
