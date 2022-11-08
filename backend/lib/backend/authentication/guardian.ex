defmodule Backend.Guardian do
  use Guardian, otp_app: :backend
  alias BackendWeb.UserController

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = UserController.get_by_id(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
