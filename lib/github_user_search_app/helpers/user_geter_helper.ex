defmodule GithubUserSearchApp.Helpers.UserGeterHelper do
  @moduledoc """
  Handles fetching user data from github
  """

  def get_user(data) do
    Finch.build(:get, "https://api.github.com/users/" <> data, get_headers())
    |> Finch.request(MyFinch)
  end

  defp get_headers do
    token = System.get_env("TOKEN")

    headers = [{"Authorization", token}]

    headers
  end
end
