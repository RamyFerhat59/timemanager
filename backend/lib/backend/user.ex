defmodule Backend.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :email]}
  schema "users" do
    field :email, :string
    field :username, :string
    # has_many :clocks, Backend.Clock
    # has_many :workingtimes, Backend.Workingtime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
  end
end
