defmodule GithubExerciseWeb.OrganizationRepositoriesViewTest do
  use ExUnit.Case, async: true

  describe "when no organization has been searched for" do
    setup do
      view = GithubExerciseWeb.OrganizationRepositoriesView.render("index.html",  view: %{
        organization_name: nil,
        organization_not_found: false,
        repositories: [],
      })

      {:ok, view: view}
    end

    test "hides the repository list", %{view: view} do
      assert find_by_test_handle(view, "repository-list-container") === nil
    end

    test "hides the not found message", %{view: view} do
      assert find_by_test_handle(view, "not-found-message") === nil
    end

  end

  describe "when an organization has been searched for and it is found" do

    setup do
      view = GithubExerciseWeb.OrganizationRepositoriesView.render("index.html",  view: %{
        organization_name: "ACME",
        organization_not_found: false,
        repositories: [
          %{ name: "FooLib", watchers: 5, url: "http://foolib"},
          %{ name: "BarLib", watchers: 10, url: "http://barlib"}
        ],
      })

      {:ok, view: view}
    end

    test "displays the organization name above the search results", %{view: view} do
      organization_name = view
        |> find_by_test_handle("organization-name")
        |> Floki.text()

      assert organization_name === "ACME"
    end

    test "displays the organization name in the search box", %{view: view} do
      [value] = view
        |> find_by_test_handle("organization-name-input")
        |> Floki.attribute("value")

      assert value === "ACME"
    end

    test "displays the number of repositories for the organization", %{view: view} do
      count = view
        |> find_by_test_handle("repository-count")
        |> Floki.text()

      assert count === "2"
    end

    test "displays the organization's repositories", %{view: view} do
      [first, second]= view
          |> find_all_by_test_handle("repository")


      assert Floki.text(first) === "FooLib (5 watchers)"
      assert Floki.attribute(first, "href") === ["http://foolib"]

      assert Floki.text(second) === "BarLib (10 watchers)"
      assert Floki.attribute(second, "href") === ["http://barlib"]
    end

    test "hides the not found message", %{view: view} do
      assert find_by_test_handle(view, "not-found-message") === nil
    end
  end

  describe "when an organization has been searched for and it is not found" do

    setup do
      view = GithubExerciseWeb.OrganizationRepositoriesView.render("index.html",  view: %{
        organization_name: "ACME",
        organization_not_found: true,
        repositories: [],
      })

      {:ok, view: view}
    end

    test "displays a not found message", %{view: view} do
      assert find_by_test_handle(view, "not-found-message") !== nil
    end

    test "hides the repository list", %{view: view} do
      assert find_by_test_handle(view, "repository-list-header") === nil
      assert find_by_test_handle(view, "repository") === nil
    end

  end


  defp find_by_test_handle(view, handle) do
    Enum.at(find_all_by_test_handle(view, handle), 0)
  end

  defp find_all_by_test_handle(view, handle) do
    {_, html_parts} = view
    html = Enum.join(html_parts, "")
    Floki.find(html, "[data-test-handle=\"#{handle}\"]")
  end

end
