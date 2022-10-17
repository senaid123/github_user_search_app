defmodule GithubUserSearchApp.Helpers.UserGeterHelper do
  def get_user(data) do
    headers = get_headers()

    Finch.build(:get, "https://api.github.com/users/" <> data, headers)
    |> Finch.request(MyFinch)
  end

  def get_headers do
    auth = System.get_env("AUTH")
    token = System.get_env("TOKEN")

    headers = [{to_string(auth), to_string(token)}]
  end
end
