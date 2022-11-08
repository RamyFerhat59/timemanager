defmodule Backend.Repo.Migrations.CreateDaysoff do
  use Ecto.Migration

  def change do
    create table(:daysoff) do
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime, null: false
      add :type, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      timestamps()
    end
  end
end
