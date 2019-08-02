defmodule ViewModel do

  def repository_list(api_organizations, organization_name) do
      repository_views = case api_organizations do
        nil -> []
        _ -> Enum.map(api_organizations, &to_organization/1)
      end

      %{
        organization_name: organization_name,
        repositories: repository_views,
        organization_not_found: api_organizations === nil,
      }
  end

  defp to_organization(api_organization) do
    %{ "name" => name,  "html_url" => url, "watchers_count" => watchers } = api_organization
    %{ name: name, watchers: watchers, url: url}
  end
end
