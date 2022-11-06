defmodule BackendWeb.WorkingtimeController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Workingtime
  alias Backend.Guardian.RoleWrapper

  action_fallback BackendWeb.FallbackController

  def index(conn, %{"userID" => userId, "start" => start_date, "end" => end_date}) do
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, userId) do
      query = from w in Workingtime,
              where: w.user_id == ^userId
              and w.start >= ^start_date
              and w.end <= ^end_date

      workingtimes = Repo.all(query) |> Repo.preload(:user)
      render(conn, "index.json", workingtimes: workingtimes)
    end
  end

  def create(conn, %{"userID" => userId, "workingtime" => wt_params}) do
    workingtime_params = %{
      "user_id" => userId,
      "start" =>  wt_params["start"],
      "end" => wt_params["end"]
    }
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, userId),
        {:ok, %Workingtime{} = workingtime} <- create_workingtime(workingtime_params) do
      workingtime = Repo.preload(workingtime, :user)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime.user.id, workingtime.id))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userId, "id" => id}) do
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, userId) do
      workingtime =
        Workingtime
        |> Repo.get_by!(id: id, user_id: userId)
        |> Repo.preload(:user)
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime =
      Workingtime
      |> Repo.get!(id)
      |> Repo.preload(:user)

    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, workingtime.user.id),
        {:ok, %Workingtime{} = workingtime} <- update_workingtime(workingtime, workingtime_params) do

      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Repo.get!(Workingtime, id)

    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, workingtime.user.id),
        {:ok, %Workingtime{}} <- Repo.delete(workingtime) do
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
