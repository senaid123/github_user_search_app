defmodule GithubUserSearchApp.Helpers.UserGeterHelper do
  @moduledoc """
  Handles fetching user data from github
  """

  def get_user(data) do
    Finch.build(:get, "https://api.github.com/users/" <> data)
    |> Finch.request(MyFinch)
  end
end
