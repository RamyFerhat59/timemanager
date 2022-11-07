defmodule BackendWeb.TeamController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Team
  alias Backend.User
  alias Backend.Guardian.RoleWrapper

  action_fallback BackendWeb.FallbackController

  def index(conn, params) do
      teams =
        Team
        |> Repo.all()
        |> Repo.preload(:manager)
        |> Repo.preload(:employees)
      render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => params}) do
    manager =
      User
      |> Repo.get!(params["manager_id"])
    employees = [manager]
    with {:ok, _current_user} <- RoleWrapper.check_manager(conn),
        {:ok, %Team{} = team} <- create_team(params),
        {:ok, %Team{} = team} <- update_team_employees(team, employees) do
      team =
        team
        |> Repo.preload(:manager)
        |> Repo.preload(:employees)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team =
      Team
      |> Repo.get!(id)
      |> Repo.preload(:manager)
      |> Repo.preload(:employees)

    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team =
      Team
      |> Repo.get!(id)
      |> Repo.preload(:manager)
      |> Repo.preload(:employees)

    with {:ok, _current_user} <- RoleWrapper.check_manager_of_team(conn, team.manager.id),
        {:ok, %Team{} = team} <- update_team(team, team_params) do

      render(conn, "show.json", team: team)
    end
  end

  def add_employee(conn, %{"id" => id, "userId" => userId}) do
    team =
      Team
      |> Repo.get!(id)
      |> Repo.preload(:manager)
      |> Repo.preload(:employees)

    employee =
      User
      |> Repo.get!(userId)

    employees = team.employees ++ [employee]
    with {:ok, _current_user} <- RoleWrapper.check_manager_of_team(conn, team.manager.id),
        {:ok, %Team{} = team} <- update_team_employees(team, employees) do

      render(conn, "show.json", team: team)
    end
  end

  def remove_employee(conn, %{"id" => id, "userId" => userId}) do
    team =
      Team
      |> Repo.get!(id)
      |> Repo.preload(:manager)
      |> Repo.preload(:employees)

    employee =
      User
      |> Repo.get!(userId)

    employees = team.employees -- [employee]
    with {:ok, _current_user} <- RoleWrapper.check_manager_of_team(conn, team.manager.id),
        {:ok, %Team{} = team} <- update_team_employees(team, employees) do

      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team =
      Team
      |> Repo.get!(id)
      |> Repo.preload(:manager)
      |> Repo.preload(:employees)

    with {:ok, _current_user} <- RoleWrapper.check_manager_of_team(conn, team.manager.id),
        {:ok, %Team{}} <- Repo.delete(team) do
      send_resp(conn, :no_content, "")
    end
  end

  # inside functions

  def create_team(attrs \\ %{}) do
    IO.inspect(attrs)
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  def update_team_employees(%Team{} = team, employees) do
    team
    |> Repo.preload(:employees)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:employees, employees)
    |> Repo.update()

  end
end
