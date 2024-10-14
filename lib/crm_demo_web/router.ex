defmodule CrmDemoWeb.Router do
  use CrmDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CrmDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CrmDemoWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/home", PageLive, :index
    live "/foo", FooLive, :index

    live "/customers", CustomerLive.Index, :index
    live "/customers/new", CustomerLive.New, :new
    live "/customers/:id/edit", CustomerLive.Index, :edit
    live "/customers/:id", CustomerLive.Show, :show
    live "/customers/:id/show/edit", CustomerLive.Show, :edit # ?
  end

  # Other scopes may use custom stacks.
  # scope "/api", CrmDemoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:crm_demo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CrmDemoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
