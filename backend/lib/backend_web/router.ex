defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Backend.Gardian.Pipeline
  end

  scope "/api", BackendWeb do
    pipe_through :api

    # SESSION

    post "/sessions/new", SessionController, :new

    # USER

    post "/users", UserController, :create

  end

  scope "/api", BackendWeb do
    pipe_through [:api, :auth]

    # SESSION

    post "/sessions/refresh", SessionController, :refresh
    post "/sessions/delete", SessionController, :delete

    # USER

    get "/users/:id", UserController, :show
    get "/users", UserController, :index
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete

    # TEAM

    get "/teams", TeamController, :index
    get "/teams/:id", TeamController, :show
    post "/teams", TeamController, :create
    put "/teams/:id", TeamController, :update
    put "/teams/:id/:userId", TeamController, :add_employee
    delete "/teams/:id/:userId", TeamController, :remove_employee
    delete "/teams/:id", TeamController, :delete

     # CLOCK

    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :post

    # WORKINGTIME

    get "/workingtimes/:userID", WorkingtimeController, :index
    get "/workingtimes/:userID/:id", WorkingtimeController, :show
    post "/workingtimes/:userID", WorkingtimeController, :create
    put "/workingtimes/:id", WorkingtimeController, :update
    delete "/workingtimes/:id", WorkingtimeController, :delete

    # DAYOFF

    get "/daysoff/:userID", DayoffController, :index
    get "/daysoff/:userID/:id", DayoffController, :show
    post "/daysoff/:userID", DayoffController, :create
    put "/daysoff/:id", DayoffController, :update
    delete "/daysoff/:id", DayoffController, :delete

  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BackendWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
