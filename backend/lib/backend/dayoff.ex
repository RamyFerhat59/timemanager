defmodule Backend.Dayoff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daysoff" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :type, :string
    belongs_to :user, Backend.User

    timestamps()
  end

  @doc false
  def changeset(dayoff, attrs) do
    dayoff
    |> cast(attrs, [:start, :end, :type, :user_id])
    |> validate_required([:start, :end, :type, :user_id])
    |> assoc_constraint(:user)
  end
end
