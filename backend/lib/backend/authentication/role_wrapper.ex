defmodule Backend.Guardian.RoleWrapper do

  # alias BackendWeb.UserController
  # alias Backend.User

  def check_current_user(conn, user_id) do
    current_user = Guardian.Plug.current_resource(conn)

    case current_user.id == check_id(user_id) or current_user.role == "admin" or current_user.role == "manager" do
      false -> {:error, :unauthorized}
      true -> {:ok, current_user}
    end
  end

  def check_manager(conn) do
    current_user = Guardian.Plug.current_resource(conn)
    case current_user.role == "manager" or current_user.role == "admin"do
      false -> {:error, :unauthorized}
      true -> {:ok, current_user}
    end
  end

  def check_manager_of_team(conn, team_manager_id) do
    current_user = Guardian.Plug.current_resource(conn)
    case (current_user.role == "manager" and current_user.id == check_id(team_manager_id)) or current_user.role == "admin" do
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
