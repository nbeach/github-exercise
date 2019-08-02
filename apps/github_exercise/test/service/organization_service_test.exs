defmodule OrganizationServiceTest do
  use ExUnit.Case
  doctest OrganizationService

  test "when a organization name has been provided creates a repository view for an organization" do
    organization = OrganizationService.repositories_for_organization("scriptdrop")
    [repository | _]= organization.repositories

    assert organization.organization_name === "scriptdrop"
    assert repository.name === "elixir_signed_overpunch"
  end

  test "when no organization name has been provided returns an empty view" do
    view = OrganizationService.repositories_for_organization(nil)

    assert view === %{
             organization_name: nil,
             organization_not_found: false,
             repositories: []
           }
  end

end
