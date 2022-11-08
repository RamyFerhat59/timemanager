defmodule Backend.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    belongs_to :manager, Backend.User
    many_to_many :employees, Backend.User, join_through: "employees_teams",  on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name, :manager_id])
    |> assoc_constraint(:manager)
  end
end
