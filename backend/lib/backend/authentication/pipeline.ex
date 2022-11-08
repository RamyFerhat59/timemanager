defmodule Backend.Gardian.Pipeline do

  use Guardian.Plug.Pipeline,
    otp_app: :backend,
    error_handler: Backend.Guardian.AuthErrorHandler,
    module: Backend.Guardian

  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
