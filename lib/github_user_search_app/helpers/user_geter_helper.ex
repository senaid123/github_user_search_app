defmodule GithubUserSearchApp.Helpers.UserGeterHelper do
  def get_user(data) do
    # auth = System.get_env("AUTH")
    # token = System.get_env("TOKEN")
    headers = [{"Authorization", "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"}]

    Finch.build(:get, "https://api.github.com/users/" <> data, headers)
    |> Finch.request(MyFinch)
  end

  def get_headers do
    # authorization = System.get_env("AUTH")
    # token = System.get_env("TOKEN")
  end
end
