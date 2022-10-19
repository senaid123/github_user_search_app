defmodule GithubUserSearchApp.Helpers.UserGeterHelper do
  def get_user(data) do
    headers = get_headers()

    Finch.build(:get, "https://api.github.com/users/" <> data, headers)
    |> Finch.request(MyFinch)
  end

  def get_headers do
    token = System.get_env("TOKEN")

    headers = [{"Authorization", token}]

    headers
  end
end
