defmodule BackendWeb.SessionView do
  use BackendWeb, :view
  alias BackendWeb.SessionView

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end

end
