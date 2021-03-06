defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BlogWeb.Context
    plug CORSPlug, origin: "*"
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BlogWeb.Schema,
      socket: BlogWeb.UserSocket,
      interface: :advanced

    forward "/", Absinthe.Plug,
      schema: BlogWeb.Schema,
      socket: BlogWeb.UserSocket
  end

end
