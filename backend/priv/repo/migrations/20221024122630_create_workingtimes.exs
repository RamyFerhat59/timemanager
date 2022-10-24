defmodule Backend.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do

      timestamps()
    end
  end
end
