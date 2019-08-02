defmodule GithubExerciseWeb.OrganizationRepositoriesController do
  use GithubExerciseWeb, :controller

  def index(conn, %{"organization_name" => organization_name}) do
    view = organization_name
      |> trim_to_nil()
      |> OrganizationService.repositories_for_organization()

    render(conn, "index.html", view: view)
  end

  def index(conn, _) do
    view = OrganizationService.repositories_for_organization(nil)
    render(conn, "index.html", view: view)
  end

  defp trim_to_nil(value) do
    cond do
      value === nil -> nil
      value |> String.trim() |> String.length() === 0 -> nil
      true -> String.trim(value)
    end
  end

end
