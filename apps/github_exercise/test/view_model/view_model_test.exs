defmodule ViewModelTest do
  use ExUnit.Case
  doctest ViewModel

  describe "repository_list_view()" do

    test "sets the organization name on the view" do
      view = ViewModel.repository_list([], "Acme")
      assert view.organization_name === "Acme"
    end

    test "when API repositories exist converts them to view repositories" do
      api_organizations = [%{
        "name" => "FooLib",
        "watchers_count" => 5,
        "html_url" => "http://someurl"
      }]

      view = ViewModel.repository_list(api_organizations, "")

      expected = [%{
        name: "FooLib",
        watchers: 5,
        url: "http://someurl"
      }]

      assert view.repositories === expected
    end

    test "when an organization is not found sets the not found flag on the view" do
      view = ViewModel.repository_list(nil, "")
      assert view.organization_not_found === true
    end

    test "when an organization is found sets the not found flag on the view" do
      view = ViewModel.repository_list([], "")
      assert view.organization_not_found === false
    end

  end

end
