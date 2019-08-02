defmodule GithubApiTest do
  use ExUnit.Case
  doctest GithubApi

  test "retrieves organizations" do
    organizations = GithubApi.organization_repositories("scriptdrop")

    assert Enum.any?(organizations, &(Map.get(&1, "name") === "elixir_signed_overpunch"))
  end

end
