defmodule GithubUserSearchAppWeb.Components.GithubUserSearchComponents do
  @moduledoc """
  Component that contains components that are included in main app, search bar, navigation, etc.
  """
  use GithubUserSearchAppWeb, :component

  alias GithubUserSearchAppWeb.GithubUserLive.Icons
  alias GithubUserSearchAppWeb.Helpers.UserBioHelper

  def search_bar(assigns) do
    ~H"""
    <div class={
      "flex mt-4 rounded-lg lg:h-[69px] lg:w-[730px] md:w-[573px]  md:h-[69px] sm:w-[327px] bg-[#1E2A47]
     #{if !@dark, do: "bg-white shadow-xl border-1"}"
    }>
      <form id="form" phx-submit="search" class="flex items-center justify-between w-full">
        <div class="px-4 py-3 color-white">
          <Icons.search />
        </div>
        <input
          type="text"
          name="search"
          value={@search}
          placeholder="Search GitHub username.."
          autocomplete="off"
          class={
            "outline-none outline-0 text-white border-0 w-full border-none bg-[#1E2A47] #{if !@dark, do: "bg-white text-[#697C9A]"}"
          }
          valid="false"
        />
        <%= if !@found do %>
          <div id="not-found" class="text-[14x] text-red-500 mr-10">
            No results
          </div>
        <% end %>

        <button
          type="submit"
          class="py-3 px-6 m-2 w background-button rounded-md text-white text-sm hover:bg-blue-500"
        >
          Search
        </button>
      </form>
    </div>
    """
  end

  def nav_top(assigns) do
    ~H"""
    <div class="flex lg:w-[730px] lg:h-[38px] md:w-[573px] justify-between items-center text-white sm:w-[327px] sm:h-[38px]">
      <p class={" text-[26px] text-[#141D2F] #{if @dark, do: "text-gray-300"}"}>devfinder</p>

      <div id="toggle-bar" phx-click="toggle_bg" class="flex items-center cursor-pointer">
        <UserBioHelper.layout_bg dark={@dark} />
      </div>
    </div>
    """
  end

  def created_at(assigns) do
    datetime =
      assigns.created_at
      |> DateTime.from_naive!("Etc/UTC")
      |> Timex.format!("%a %b %Y", :strftime)

    ~H"""
    <time class={"text-[#F6F8FF] text-[15px] #{if !@dark, do: "text-[#697C9A]"}"}>
      Joined <%= datetime %>
    </time>
    """
  end

  def table_data(assigns) do
    ~H"""
    <div class="items-center w-full">
      <table class="items-center justify-start w-full text-center">
        <tr class="text-[15px] text-[#697C9A]">
          <td>Repos</td>
          <td>Followers</td>
          <td>Following</td>
        </tr>
        <tr class={"text-[#F6F8FF] font-bold text-2xl #{if !@dark, do: "text-[#2B3442]"}"}>
          <td><%= @github_user.public_repos %></td>
          <td><%= @github_user.followers %></td>
          <td><%= @github_user.following %></td>
        </tr>
      </table>
    </div>
    """
  end

  def user_bio_top(assigns) do
    ~H"""
    <div class="flex">
      <img
        class="rounded-[50%] lg:w-[117px] lg:h-[117px] md:w-[117px] md:h-[117px] sm:w-[70px] sm:h-[70px] mt-8"
        src={@github_user.avatar_url}
      />
      <div class="block lg:w-full lg:mx-5 md:mx-8 sm:mx-4 mt-8">
        <div class="justify-between lg:flex md:block">
          <div class="block">
            <h2
              id="user-name"
              class={
                "text-white font-bold lg:text-[26px] md:text-[26px] sm:text-[22px] #{if !@dark, do: "text-[#141D2F]"}"
              }
            >
              <%= @github_user.name %>
            </h2>
            <a
              href={@github_user.html_url}
              target="_blank"
              class="text-[16px] text-[#0079FF] hover:border-b-[1px] border-[#0079FF]"
            >
              <%= "@" <> @github_user.login %>
            </a>
          </div>
          <div>
            <.created_at created_at={@github_user.created_at} dark={@dark} />
          </div>
        </div>
        <div class="lg:text-[15px] lg:mt-3 lg:flex md:hidden sm:hidden">
          <UserBioHelper.user_bio bio={@github_user.bio} dark={@dark} />
        </div>
      </div>
    </div>
    """
  end

  def user_info_bottom(assigns) do
    ~H"""
    <div class="md:mr-14 lg:mr-0 sm:mr-0">
      <div class="flex items-center gap-3">
        <Icons.location />
        <UserBioHelper.location location={@github_user.location} />
      </div>
      <div class="flex items-center gap-3 lg:mt-3 md:mt-3 sm:mt-3">
        <Icons.website />
        <UserBioHelper.website dark={@dark} blog={@github_user.blog} />
      </div>
    </div>

    <div class="sm:mt-3 lg:mt-0 md:mt-0">
      <div class="flex items-center gap-3">
        <Icons.twitter />
        <UserBioHelper.twitter_link twitter={@github_user.twitter_username} />
      </div>
      <div class="flex items-center gap-3 mt-3">
        <Icons.company />
        <UserBioHelper.user_company company={@github_user.company} />
      </div>
    </div>
    """
  end
end
