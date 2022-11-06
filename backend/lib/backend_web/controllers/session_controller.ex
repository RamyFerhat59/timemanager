defmodule BackendWeb.SessionController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Guardian
  alias Backend.User

  action_fallback BackendWeb.FallbackController

  def new(conn, params) do
    with {:ok, user} <- authentication(params["email"],params["password"]) do
      {:ok, access_token, _claims} =
        Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {1, :weeks})

      {:ok, refresh_token, _claims} =
        Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {1, :weeks})

      conn
        |> put_resp_cookie("ruid", refresh_token)
        |> put_status(:created)
        |> render("token.json", access_token: access_token)
    end
  end

  def refresh(conn, _params) do
    refresh_token =
      Plug.Conn.fetch_cookies(conn)
        |> Map.from_struct()
        |> get_in([:cookies, "ruid"])
    with {:ok, _old_stuff, {new_access_token, _new_claims}} <- Guardian.exchange(refresh_token, "refresh", "access") do
      conn
        |> put_status(:created)
        |> render("token.json", %{access_token: new_access_token})

    end
  end

  def delete(conn, _params) do
    conn
      |> delete_resp_cookie("ruid")
      |> put_status(200)
      |> text("Log out succesful")
  end


  # inside functions

  def authentication(email, password) do
    with user <- get_by_email(email) do
      case validate_password(password, user.password) do
        false -> {:error, :unauthorized}
        true -> {:ok, user}
      end
    end
  end

  def get_by_email(email) do
    User
      |> Repo.get_by!(email: email)
      |> Repo.preload(:clock)
  end

  def validate_password(password, encrypted_password) do
    Bcrypt.verify_pass(password, encrypted_password)
  end



end
