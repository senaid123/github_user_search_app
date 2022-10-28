defmodule GithubUserSearchApp.GithubHttpClient do
  def api_client, do: Application.get_env(:github_user_search_app, :api_client)

  def get_search_user(user) do
    with {:ok, user} <- api_client().get_github_user(user) do
      {:ok, user}
    else
      err -> err
    end
  end
end
