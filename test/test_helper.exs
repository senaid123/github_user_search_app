ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubUserSearchApp.Repo, :manual)

Mox.defmock(GithubMockClient, for: GithubUserSearchApp.UserGetterBehaviour)
