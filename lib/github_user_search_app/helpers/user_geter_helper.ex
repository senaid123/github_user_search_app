defmodule GithubUserSearchApp.Helpers.UserGeterHelper do
  def get_user(data) do
    Finch.build(:get, "https://api.github.com/users/" <> data)
    |> Finch.request(MyFinch)
  end
end
