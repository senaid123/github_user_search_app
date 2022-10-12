defmodule GithubUserSearchApp.User.GithubUser do
  defstruct [:full_name, :username, :link]
  @types %{full_name: :string, username: :string, link: :string}
  import Ecto.Changeset

  def changeset(%__MODULE__{} = user, attrs) do
    {user, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:full_name, :username])
  end
end
