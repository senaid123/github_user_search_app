defmodule GithubUserSearchApp.UserGetterBehaviour do
  @moduledoc false
  @callback get_github_user(data :: String.t()) ::
              {:ok, response :: map()} | {:error, reason :: term()}
end
