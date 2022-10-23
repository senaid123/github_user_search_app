defmodule GithubUserSearchAppWeb.Components.GithubUserSearchComponents do
  use GithubUserSearchAppWeb, :component

  alias GithubUserSearchAppWeb.GithubUserLive.Icons
  alias GithubUserSearchAppWeb.Helpers.UserBioHelper

  def github_search_component(assigns) do
    ~H"""
    <div class="">
      <.nav_top />
      <.search_bar search={@search} />

      <%= if @github_user do %>
        <%= if @loading do %>
          <div class="items-center justify-center fixed">
            <img width="500px" src="../images/spinner.webp" />
            <h2 class="text-[100px] text-white">Loading</h2>
          </div>
        <% else %>
          <div class="relative background-info lg:h-[419px] lg:w-[730px] md:h-[481px] md:w-[573px] sm:h-[517px] sm:w-[327px] mt-4 rounded-lg">
            <div class="m-8">
              <div class="flex">
                <img
                  class="rounded-[50%] lg:w-[117px] md:w-[117px] sm:w-[70px]  mt-8 "
                  src={@github_user.avatar_url}
                />
                <div class="block w-full lg:mx-5 md:mx-8 mt-10">
                  <div class="justify-between lg:flex md:block">
                    <div class="block">
                      <h2 class="text-white font-bold text-[26px]"><%= @github_user.name %></h2>
                      <a
                        href={@github_user.html_url}
                        target="_blank"
                        class="text-[16px] text-[#0079FF]"
                      >
                        <%= "@" <> @github_user.login %>
                      </a>
                    </div>
                    <div>
                      <.created_at created_at={@github_user.created_at} />
                    </div>
                  </div>
                  <div class="text-[15px] lg:mt-3 lg:flex md:hidden ">
                    <UserBioHelper.user_bio bio={@github_user.bio} />
                  </div>
                </div>
              </div>
              <div class="text-[15px] md:mt-5 lg:hidden md:flex md:w-full ">
                <UserBioHelper.user_bio bio={@github_user.bio} />
              </div>
              <div class="w-full h-full flex items-center justify-center ">
                <div class="h-[185px] w-[480px] lg:ml-[14%]">
                  <div class="flex items-center lg:mt-10 md:mt-6 background py-5 rounded-lg">
                    <.table_data github_user={@github_user} />
                  </div>
                  <div class="lg:flex md:flex items-center lg:justify-between md:justify-start w-full lg:gap-4 my-12 text-[15px]">
                    <div class="md:mr-14">
                      <div class="flex items-center gap-3">
                        <Icons.company />
                        <UserBioHelper.user_company company={@github_user.company} />
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
    <div class="background-info flex mt-4 rounded-lg h-[69px] lg:w-[730px] md:w-[573px] sm:w-[327px] ">
      <form phx-submit="search" class="flex items-center justify-between w-full">
        <div class="px-4 py-3 color-white">
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
        <button type="submit" class="py-3 px-6 m-2 w background-button rounded-md text-white text-sm">
          Search
        </button>
      </form>
    </div>
    """
  end

  def nav_top(assigns) do
    ~H"""
    <div class="flex lg:w-[730px] lg:h-[38px] md:w-[573px] justify-between items-center text-white hover:text-gray-300 cursor-pointer sm:w-[327px] sm:h-[38px]">
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

  def table_data(assigns) do
    ~H"""
    <div class="text-white items-center w-full ml-14">
      <table class="items-center justify-start w-full  ">
        <tr class="text-[15px] text-[#697C9A]">
          <td>Repos</td>
          <td>Followers</td>
          <td>Following</td>
        </tr>
        <tr class="text-[#F6F8FF] font-bold text-2xl">
          <td><%= @github_user.public_repos %></td>
          <td><%= @github_user.followers %></td>
          <td><%= @github_user.following %></td>
        </tr>
      </table>
    </div>
    """
  end
end
