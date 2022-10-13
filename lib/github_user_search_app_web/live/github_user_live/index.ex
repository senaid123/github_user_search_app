defmodule GithubUserSearchAppWeb.GithubUserLive.Index do
  use GithubUserSearchAppWeb, :live_view
  use Phoenix.HTML
  alias GithubUserSearchApp.UserGetter
  alias GithubUserSearchAppWeb.GithubUserLive.Icons

  def mount(_params, _session, socket) do
    {:ok, octocat} = UserGetter.get_github_user("octocat")
    socket =
      assign(socket,
        github_user: octocat,
        search: "",
        loading: false
      )

    {:ok, socket}
  end

  def handle_event("search", %{"search" => search}, socket) do
    send(self(), {:run_search, search})

    socket =
      assign(socket,
        github_user: nil,
        search: search,
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_search, search}, socket) do
    case UserGetter.get_github_user(search) do
      {:ok, github_user} ->
        socket = assign(socket, github_user: github_user, loading: false)
        {:noreply, socket}

      _ ->
        socket =
          socket
          |> put_flash(:info, "No users matching \"#{search}\"")
          |> assign(gitub_user: "", loading: false)

        {:noreply, socket}
    end
  end
end
