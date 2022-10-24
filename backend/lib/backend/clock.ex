defmodule Backend.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do


    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [])
    |> validate_required([])
  end
end
