defmodule Backend.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :email]}
  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string
    has_one :clock, Backend.Clock
    # has_many :workingtimes, Backend.Workingtime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> unique_constraint(:email)
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> unique_constraint(:email)
    |> encrypt_password()
  end

  def encrypt_password(user) do
    with password <- fetch_field!(user, :password) do
      encrypted_password = Bcrypt.Base.hash_password(password, Bcrypt.Base.gen_salt(12, true))
      put_change(user, :password, encrypted_password)
    end
  end
end
