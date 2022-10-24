defmodule Backend.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do


    timestamps()
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [])
    |> validate_required([])
  end
end
