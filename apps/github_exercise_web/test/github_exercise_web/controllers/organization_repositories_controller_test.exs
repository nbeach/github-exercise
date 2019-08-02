defmodule GithubExerciseWeb.OrganizationRepositoriesControllerTest do
  use GithubExerciseWeb.ConnCase

  describe "when an organization has been searched for" do

    test "displays repository names", %{conn: conn} do
      conn = get(conn, "/?organization_name=scriptdrop")
      assert html_response(conn, 200) =~ "sentry-elixir"
    end

  end

end
