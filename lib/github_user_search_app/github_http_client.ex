defmodule GithubUserSearchApp.GithubHttpClient do
  @moduledoc """
  Handles api client calls depending on environment
  """

  def api_client, do: Application.get_env(:github_user_search_app, :api_client)

  def search_user(user) do
    response = api_client().get_user(user)

    case response do
      {:ok, %{status: 200, body: body}} ->
        {:ok, items} = Jason.decode(body)
        items = parse_data(items)

        {:ok, items}

      {_, response} ->
        {:error, response}
    end
  end

  defp parse_data(data) do
    %{
      "avatar_url" => avatar_url,
      "bio" => bio,
      "company" => company,
      "created_at" => created_at,
      "followers" => followers,
      "following" => following,
      "html_url" => html_url,
      "location" => location,
      "login" => user_name,
      "name" => full_name,
      "public_repos" => public_repos,
      "twitter_username" => twitter_username,
      "blog" => blog
    } = data

    %{
      avatar_url: avatar_url,
      bio: bio,
      company: company,
      created_at: Timex.parse!(created_at, "{RFC3339z}"),
      followers: followers,
      following: following,
      html_url: html_url,
      location: location,
      login: user_name,
      name: full_name,
      public_repos: public_repos,
      twitter_username: twitter_username,
      blog: blog
    }
  end
end
