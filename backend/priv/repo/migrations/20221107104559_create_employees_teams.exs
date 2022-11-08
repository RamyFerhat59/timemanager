defmodule Backend.Repo.Migrations.CreateEmployeesTeams do
  use Ecto.Migration

  def change do
    create table(:employees_teams) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :team_id, references(:teams, on_delete: :delete_all), null: false
    end

    create unique_index(:employees_teams, [:user_id, :team_id])
  end
end
