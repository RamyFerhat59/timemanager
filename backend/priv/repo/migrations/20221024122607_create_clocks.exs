defmodule Backend.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do

      timestamps()
    end
  end
end
