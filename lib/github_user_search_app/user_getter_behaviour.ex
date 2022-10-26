defmodule GithubUserSearchApp.UserGetterBehaviour do
  @moduledoc false
  @callback get_github_user(binary()) :: {:ok, any()} | {:error, any()}
end
