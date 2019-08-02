defmodule GithubExerciseWeb.Router do
  use GithubExerciseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GithubExerciseWeb do
    pipe_through :browser

    get "/", OrganizationRepositoriesController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GithubExerciseWeb do
  #   pipe_through :api
  # end
end
