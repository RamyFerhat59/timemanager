defmodule Backend.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :status, :time]}
  schema "clocks" do
    field :status, :boolean, default: true
    field :time, :naive_datetime
    belongs_to :user, Backend.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :user_id])
    |> validate_required([:time, :user_id])
    |> unique_constraint(:user_id)
    |> assoc_constraint(:user)
  end
end
