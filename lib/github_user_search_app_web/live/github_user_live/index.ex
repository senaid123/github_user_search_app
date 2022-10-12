defmodule GithubUserSearchAppWeb.GithubUserLive.Index do
  use GithubUserSearchAppWeb, :live_view
  alias GithubUserSearchApp.UserGetter

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:user, nil)

    {:ok, socket}
  end

  def handle_event("search", %{"user" => user} = _params, socket) do
    UserGetter.get_github_user(user)
    socket = assign(socket, :user, user)
    {:noreply, socket}
  end
end
