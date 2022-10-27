defmodule BackendWeb.ClockController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Clock
  alias BackendWeb.WorkingtimeController, as: WorkingtimeCtrl

  action_fallback BackendWeb.FallbackController

  def post(conn, %{"userID" => userId}) do

    query = from c in Clock, where: c.user_id == ^userId
    clock_exist = Repo.exists?(query)

    if clock_exist do
      clock =
        Clock
        |> Repo.get_by!(user_id: userId)
        |> Repo.preload(:user)

      if clock.status do
        workingtime_params = %{
          "user_id" => clock.user.id,
          "start" =>  clock.time,
          "end" => NaiveDateTime.utc_now()
        }
        WorkingtimeCtrl.create_workingtime(workingtime_params)
      end
      with {:ok, %Clock{} = clock} <- update_clock(clock) do
        clock = Repo.preload(clock, :user)
        render(conn, "show.json", clock: clock)
      end
    else
      clock_params = %{"user_id" => userId, "time" =>  NaiveDateTime.utc_now()}
      with {:ok, %Clock{} = clock} <- create_clock(clock_params) do
        clock = Repo.preload(clock, :user)
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
        |> render("show.json", clock: clock)
      end
    end
  end

  def show(conn, %{"userID" => userId}) do
    clock =
      Clock
      |> Repo.get_by!(user_id: userId)
      |> Repo.preload(:user)
    render(conn, "show.json", clock: clock)
  end

  # inside functions

  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  def update_clock(%Clock{} = clock) do
    clock
    |> Clock.changeset(%{"status" => !clock.status, "time" => NaiveDateTime.utc_now()})
    |> Repo.update()
  end

end
