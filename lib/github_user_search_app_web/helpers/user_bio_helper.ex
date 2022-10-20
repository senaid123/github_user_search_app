defmodule GithubUserSearchAppWeb.Helpers.UserBioHelper do
  use GithubUserSearchAppWeb, :component

  def user_bio(%{bio: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">This user have no bio</h2>
    """
  end

  def user_bio(assigns) do
    ~H"""
    <h2 class="text-[#F6F8FF]"><%= @bio %></h2>
    """
  end

  def user_company(%{company: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def user_company(assigns) do
    ~H"""
    <h2 class="text-[#F6F8FF]"><%= @company %></h2>
    """
  end

  def website(%{website: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def website(assigns) do
    ~H"""
    <h2 class="text-[#F6F8FF]"><%= @website %></h2>
    """
  end

  def location(%{location: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def location(assigns) do
    ~H"""
    <h2 class="text-[#F6F8FF]"><%= @location %></h2>
    """
  end

  def twitter_link(%{twitter: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def twitter_link(assigns) do
    ~H"""
    <h2 class="text-[#F6F8FF]"><%= @twitter %></h2>
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
