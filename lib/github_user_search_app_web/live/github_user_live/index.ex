defmodule GithubUserSearchAppWeb.GithubUserLive.Index do
  @moduledoc """
  Displays search page with octocat example, handles github user profile searches
  """
  use GithubUserSearchAppWeb, :live_view
  use Phoenix.HTML

  alias GithubUserSearchApp.UserGetter
  alias GithubUserSearchAppWeb.Components.GithubUserSearchComponents
  alias GithubUserSearchAppWeb.Helpers.UserBioHelper
  alias GithubUserSearchAppWeb.GithubUserLive.Icons

  def mount(_params, _session, socket) do
    {:ok, octocat} = UserGetter.get_github_user("octocat")

    socket =
      assign(socket,
        github_user: octocat,
        search: "",
        dark: true,
        found: true
      )

    {:ok, socket}
  end

  def handle_event("toggle_bg", _params, socket) do
    bg_collor = socket.assigns.dark
    socket = assign(socket, dark: !bg_collor)
    {:noreply, socket}
  end

  def handle_event("search", %{"search" => search}, socket) do
    send(self(), {:run_search, search})

    socket =
      assign(socket,
        github_user: nil,
        search: search,
        found: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_search, search}, socket) do
    case UserGetter.get_github_user(search) do
      {:ok, github_user} ->
        socket = assign(socket, github_user: github_user, found: true)
        {:noreply, socket}

      _ ->
        {:ok, octocat} = UserGetter.get_github_user("octocat")

        socket = assign(socket, found: false, github_user: octocat)

        {:noreply, socket}
    end
  end
end
