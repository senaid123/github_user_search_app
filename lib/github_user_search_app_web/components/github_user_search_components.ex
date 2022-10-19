defmodule GithubUserSearchAppWeb.Components.GithubUserSearchComponents do
  use GithubUserSearchAppWeb, :component

  alias GithubUserSearchAppWeb.GithubUserLive.Icons

  def github_search_component(assigns) do
    ~H"""
    <div class="w-[730px] h-[419px] mt-[-15%]">
      <.nav_top />
      <.search_bar search={@search} />

      <%= if @loading do %>
        <div>LOADIINGG....</div>
      <% else %>
        <%= if @github_user do %>
          <div class="background-info h-[444px] mt-4">
            <div class="ml-20">
              <div class="flex ">
                <img width="117px" class="rounded-[50%] " src={@github_user.avatar_url} />
                <div class="block w-full">
                  <div class="justify-between flex">
                    <div class="block">
                      <h2 class="text-white font-bold text-[26px]"><%= @github_user.name %></h2>
                      <h2 class="text-[16px] text-[#0079FF]"><%= "@" <> @github_user.login %></h2>
                    </div>
                    <div>
                      <.created_at created_at={@github_user.created_at} />
                    </div>
                  </div>
                  <div>
                    <h2 class="text-white text-[15px]">
                      <%= if @github_user.bio do %>
                        <%= @github_user.bio %>
                      <% else %>
                        This profile has no bio
                      <% end %>
                    </h2>
                  </div>
                </div>
              </div>

              <div class="">
                <table>
                  <tr>
                    <td>Repos</td>
                    <td>Followers</td>
                    <td>Following</td>
                  </tr>
                  <tr>
                    <td><%= @github_user.public_repos %></td>
                    <td><%= @github_user.followers %></td>
                    <td><%= @github_user.following %></td>
                  </tr>
                </table>
              </div>
              <div class="flex">
                <div>
                  <div class="text-white flex">
                    <Icons.company />
                    <h2><%= @github_user.company %></h2>
                  </div>
                  <div class="text-white flex">
                    <Icons.website />
                    <h2><%= @github_user.html_url %></h2>
                  </div>
                </div>

                <div>
                  <div class="text-white flex">
                    <Icons.location />
                    <h2><%= @github_user.location %></h2>
                  </div>
                  <div class="text-white flex">
                    <Icons.twitter />
                    <h2><%= @github_user.twitter_username %></h2>
                  </div>
                </div>
              </div>
            </div>
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  def search_bar(assigns) do
    ~H"""
    <div class="background-info flex mt-4 rounded-md w-[730px] h-[69px]">
      <form phx-submit="search" class="flex items-center justify-between w-full">
        <div class="m-2">
          <Icons.search />
        </div>
        <input
          type="text"
          name="search"
          value={@search}
          placeholder="Search Github username.."
          autocomplete="off"
          class=" outline-none outline-0  border-0 w-full background-info border-none"
        />
        <button type="submit" class="p-2 m-2 background-button rounded-md text-white text-sm">
          Search
        </button>
      </form>
    </div>
    """
  end

  def nav_top(assigns) do
    ~H"""
    <div class="flex justify-between items-center text-white hover:text-gray-300 cursor-pointer">
      <p class="text-[26px] ">devfinder</p>

      <div class="flex items-center">
        <p class="pr-2">light</p>
        <Icons.sun />
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
    <time class="text-white text-[15px]">Joined <%= datetime %></time>
    """
  end
end
