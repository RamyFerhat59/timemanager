defmodule Backend.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: true
    field :time, :naive_datetime
    belongs_to :user, Backend.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status])
    |> cast_assoc(attrs, :user)
    |> validate_required([:time, :status, :user])
  end
end
