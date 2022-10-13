defmodule GithubUserSearchApp.UserGetter do
  alias GithubUserSearchApp.User.GithubUser
  alias GithubUserSearchApp.Helpers.UserGeterHelper

  def get_github_user(data) do
    json_data = UserGeterHelper.get_user(data)

    with {:ok, %{status: 200, body: body}} <- json_data,
         {:ok, items} = Jason.decode(body) do
      items = Stream.map(items, &parse_data/1)

      {:ok, items}
    else
      {_, json_data} -> {:error, json_data}
    end
  end

  def parse_data(data) do
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
      "twitter_username" => twitter_username
    } = data

    %{
      avatar_url: avatar_url,
      bio: bio,
      company: company,
      created_at: Timex.parse!(created_at, "{RFC3339}"),
      followers: followers,
      following: following,
      html_url: html_url,
      location: location,
      login: user_name,
      name: full_name,
      public_repos: public_repos,
      twitter_username: twitter_username
    }
  end
end
