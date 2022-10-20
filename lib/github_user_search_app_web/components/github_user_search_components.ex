defmodule GithubUserSearchAppWeb.Components.GithubUserSearchComponents do
  use GithubUserSearchAppWeb, :component

  alias GithubUserSearchAppWeb.GithubUserLive.Icons
  alias GithubUserSearchAppWeb.Helpers.UserBioHelper

  def github_search_component(assigns) do
    ~H"""
    <div class="w-[730px] h-[419px] mt-[-15%]">
      <.nav_top />
      <.search_bar search={@search} />

      <%= if @github_user do %>
        <%= if @loading do %>
          <div class="items-center justify-center fixed">
            <img width="500px" src="../images/spinner.webp" />
            <h2 class="text-[100px] text-white">Loading</h2>
          </div>
        <% else %>
          <div class="background-info h-[444px] mt-4 rounded-lg">
            <div class="m-8">
              <div class="flex p-">
                <img width="117px" class="rounded-[50%] mt-8 " src={@github_user.avatar_url} />
                <div class="block w-full mx-5 mt-10">
                  <div class="justify-between flex">
                    <div class="block">
                      <h2 class="text-white font-bold text-[26px]"><%= @github_user.name %></h2>
                      <a href={@github_user.html_url} class="text-[16px] text-[#0079FF]">
                        <%= "@" <> @github_user.login %>
                      </a>
                    </div>
                    <div>
                      <.created_at created_at={@github_user.created_at} />
                    </div>
                  </div>
                  <div class="text-[15px] mt-3">
                    <UserBioHelper.user_bio bio={@github_user.bio} />
                  </div>
                </div>
              </div>
              <div class="w-full h-full flex items-center justify-center ">
                <div class="h-[185px] w-[480px] ml-[14%]">
                  <div class="flex items-center mt-10 background py-5 rounded-lg">
                    <UserBioHelper.table_data github_user={@github_user} />
                  </div>
                  <div class="flex items-center justify-between w-full  gap-4 my-12 text-[15px]">
                    <div>
                      <div class="flex items-center gap-3">
                        <Icons.company />
                        <UserBioHelper.user_company company={@github_user.company} />start
                      </div>
                      <div class="flex items-center gap-3 mt-3">
                        <Icons.website />
                        <UserBioHelper.website website={@github_user.html_url} />
                      </div>
                    </div>

                    <div>
                      <div class="flex items-center gap-3">
                        <Icons.location />
                        <UserBioHelper.location location={@github_user.location} />
                      </div>
                      <div class="flex items-center gap-3 mt-3">
                        <Icons.twitter />
                        <UserBioHelper.twitter_link twitter={@github_user.twitter_username} />
                      </div>
                    </div>
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
    <div class="background-info flex mt-4 rounded-lg w-[730px] h-[69px]">
      <form phx-submit="search" class="flex items-center justify-between w-full">
        <div class="m-2 color-white">
          <Icons.search />
        </div>
        <input
          type="text"
          name="search"
          value={@search}
          placeholder="Search Github username.."
          autocomplete="off"
          class=" outline-none outline-0 text-white border-0 w-full background-info border-none"
          valid="false"
        />
        <button type="submit" class="p-3 m-2 background-button rounded-md text-white text-sm">
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
    <time class="text-[#F6F8FF] text-[15px]">Joined <%= datetime %></time>
    """
  end
end
