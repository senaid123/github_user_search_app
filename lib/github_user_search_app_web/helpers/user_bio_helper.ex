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
    company_link =
      assigns.company
      |> String.split("@")
      |> Enum.at(1)

    ~H"""
    <a href={"https://github.com/" <> company_link} target="_blank" class="text-[#F6F8FF]">
      <%= @company %>
    </a>
    """
  end

  def website(%{website: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def website(assigns) do
    ~H"""
    <a href={@website} target="_blank" class="text-[#F6F8FF]"><%= @website %></a>
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
    <a href={"https://twitter.com/" <> @twitter} target="_blank" class="text-[#F6F8FF]">
      <%= @twitter %>
    </a>
    """
  end
end
