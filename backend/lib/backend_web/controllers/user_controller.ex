defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.User
  alias Backend.Guardian.RoleWrapper

  action_fallback BackendWeb.FallbackController

  def index(conn, params) do
    if not is_nil(params["email"]) and not is_nil(params["username"]) do
      user =
        User
        |> Repo.get_by!([email: params["email"], username: params["username"]])
        |> Repo.preload(:clock)
      with {:ok, _current_user} <- RoleWrapper.check_current_user(conn,user.id) do
        render(conn, "show.json", user: user)
      end
    else
      with {:ok, _current_user} <- RoleWrapper.check_admin(conn) do
        users =
          User
          |> Repo.all()
          |> Repo.preload(:clock)
        render(conn, "index.json", users: users)
      end
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- create_user(user_params) do
      user = Repo.preload(user, :clock)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn,id),
        user <- get_by_id(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)

    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, id),
        {:ok, %User{} = user} <- update_user(user, user_params) do

      user = Repo.preload(user, :clock)
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, id),
        {:ok, %User{}} <- Repo.delete(user) do

      send_resp(conn, :no_content, "")
    end
  end

  # inside functions

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  def get_by_id(id) do
    User
      |> Repo.get!(id)
      |> Repo.preload(:clock)
  end

end
