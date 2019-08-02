defmodule GithubApi do

  def organization_repositories(organization_name) do
    case HTTPoison.get("https://api.github.com/orgs/#{organization_name}/repos") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> Poison.decode!(body)
      {:ok, %HTTPoison.Response{status_code: 404}} -> nil
    end
  end

end
