defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.User

  action_fallback BackendWeb.FallbackController

  def index(conn, params) do
    if not is_nil(params["email"]) and not is_nil(params["username"]) do
      user =
        User
        |> Repo.get_by!([email: params["email"], username: params["username"]])
        |> Repo.preload(:clock)
      render(conn, "show.json", user: user)
    else
      users =
        User
        |> Repo.all()
        |> Repo.preload(:clock)
      render(conn, "index.json", users: users)
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
    user =
      User
      |> Repo.get!(id)
      |> Repo.preload(:clock)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)

    with {:ok, %User{} = user} <- update_user(user, user_params) do
      user = Repo.preload(user, :clock)
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    with {:ok, %User{}} <- Repo.delete(user) do
      send_resp(conn, :no_content, "")
    end
  end

  # inside functions

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

end
