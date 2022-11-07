defmodule BackendWeb.DayoffController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Dayoff
  alias Backend.Guardian.RoleWrapper

  action_fallback BackendWeb.FallbackController

  def index(conn, %{"userID" => userId, "start" => start_date, "end" => end_date}) do
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, userId) do
      query = from w in Dayoff,
              where: w.user_id == ^userId
              and w.start >= ^start_date
              and w.end <= ^end_date

      daysoff = Repo.all(query) |> Repo.preload(:user)
      render(conn, "index.json", daysoff: daysoff)
    end
  end

  def create(conn, %{"userID" => userId, "dayoff" => wt_params}) do
    dayoff_params = %{
      "user_id" => userId,
      "start" =>  wt_params["start"],
      "end" => wt_params["end"],
      "type" => wt_params["type"]
    }
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, userId),
        {:ok, %Dayoff{} = dayoff} <- create_dayoff(dayoff_params) do
      dayoff = Repo.preload(dayoff, :user)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.dayoff_path(conn, :show, dayoff.user.id, dayoff.id))
      |> render("show.json", dayoff: dayoff)
    end
  end

  def show(conn, %{"userID" => userId, "id" => id}) do
    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, userId) do
      dayoff =
        Dayoff
        |> Repo.get_by!(id: id, user_id: userId)
        |> Repo.preload(:user)
      render(conn, "show.json", dayoff: dayoff)
    end
  end

  def update(conn, %{"id" => id, "dayoff" => dayoff_params}) do
    dayoff =
      Dayoff
      |> Repo.get!(id)
      |> Repo.preload(:user)

    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, dayoff.user.id),
        {:ok, %Dayoff{} = dayoff} <- update_dayoff(dayoff, dayoff_params) do

      render(conn, "show.json", dayoff: dayoff)
    end
  end

  def delete(conn, %{"id" => id}) do
    dayoff =
      Dayoff
      |> Repo.get!(id)
      |> Repo.preload(:user)

    with {:ok, _current_user} <- RoleWrapper.check_current_user(conn, dayoff.user.id),
        {:ok, %Dayoff{}} <- Repo.delete(dayoff) do
      send_resp(conn, :no_content, "")
    end
  end

  # inside functions

  def create_dayoff(attrs \\ %{}) do
    %Dayoff{}
    |> Dayoff.changeset(attrs)
    |> Repo.insert()
  end

  def update_dayoff(%Dayoff{} = dayoff, attrs) do
    dayoff
    |> Dayoff.changeset(attrs)
    |> Repo.update()
  end

end
