defmodule BackendWeb.ClockController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Clock
  alias Backend.User

  action_fallback BackendWeb.FallbackController

  # def index(conn, _params) do
  #   clocks = Repo.all(Clock)
  #   render(conn, "index.json", clocks: clocks)
  # end

  def create(conn, %{"userID" => userId}) do
    clock_params = %{"user_id" => userId, "time" =>  NaiveDateTime.utc_now()}
    with {:ok, %Clock{} = clock} <- create_clock(clock_params) do
      clock = Repo.preload(clock, :user)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
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

end
