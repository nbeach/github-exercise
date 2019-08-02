defmodule OrganizationService do

  def repositories_for_organization(organization_name) do
    if(organization_name === nil) do
      ViewModel.repository_list([], nil)
    else
      organization_name
        |> GithubApi.organization_repositories()
        |> ViewModel.repository_list(organization_name)
    end
  end

end
