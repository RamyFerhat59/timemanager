defmodule BackendWeb.WorkingtimeController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Workingtime
  alias Backend.User

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Repo.all(Workingtime)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => userId}) do
    workingtime_params = %{"user_id" => userId, "time" =>  NaiveDateTime.utc_now()}
    with {:ok, %Workingtime{} = workingtime} <- create_workingtime(workingtime_params) do
      workingtime = Repo.preload(workingtime, :user)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userId}) do
    workingtime =
      Workingtime
      |> Repo.get_by!(user_id: userId)
      |> Repo.preload(:user)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Repo.get!(Workingtime, id)

    with {:ok, %Workingtime{} = workingtime} <- update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Repo.get!(Workingtime, id)

    with {:ok, %Workingtime{}} <- Repo.delete(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  # inside functions

  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

end
