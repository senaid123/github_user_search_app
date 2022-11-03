defmodule GithubUserSearchAppTest.UserGetterTest do
  use ExUnit.Case

  alias GithubUserSearchApp.GithubHttpClient

  import Mox

  setup :verify_on_exit!

  describe "get_github_user/1" do
    test "fails to fetch invalid username" do
      invalid_data = "Invalid data"

      GithubMockClient
      |> expect(:get_user, fn search ->
        assert search == "12313213214"

        {:error, invalid_data}
      end)

      GithubHttpClient.search_user("12313213214")
    end

    test "fetches user data" do
      user_data = %{
        avatar_url: "https://avatars.githubusercontent.com/u/583231?v=4",
        bio: nil,
        company: "@github",
        created_at: ~U[2011-01-25 18:44:36Z],
        followers: 7440,
        following: 9,
        html_url: "https://github.com/octocat",
        location: "San Francisco",
        login: "octocat",
        name: "The Octocat",
        public_repos: 8,
        twitter_username: nil
      }

      GithubMockClient
      |> expect(:get_user, fn user ->
        assert user == "octocat"

        {:ok, user_data}
      end)

      {:ok, result} = GithubHttpClient.search_user("octocat")

      assert result.avatar_url == "https://avatars.githubusercontent.com/u/583231?v=4"
      assert result.bio == nil
      assert result.company == "@github"
      assert result.created_at == ~U[2011-01-25 18:44:36Z]
      assert result.followers == 7440
      assert result.following == 9
      assert result.html_url == "https://github.com/octocat"
      assert result.location == "San Francisco"
      assert result.login == "octocat"
      assert result.name == "The Octocat"
      assert result.public_repos == 8
      assert result.twitter_username == nil
    end
  end
end
