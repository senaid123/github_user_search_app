defmodule GithubUserSearchAppWeb.Helpers.UserBioHelper do
  use GithubUserSearchAppWeb, :component

  alias GithubUserSearchAppWeb.GithubUserLive.Icons

  def layout_bg(%{dark: true} = assigns) do
    ~H"""
    <p class="pr-2">LIGHT</p>
    <Icons.sun />
    """
  end

  def layout_bg(%{dark: false} = assigns) do
    ~H"""
    <p class="pr-2 text-[#1E2A47]">DARK</p>
    <Icons.moon />
    """
  end

  def user_bio(%{bio: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">This user have no bio</h2>
    """
  end

  def user_bio(assigns) do
    ~H"""
    <h2 class={if @dark do "text-[#F6F8FF]" else "text-[#697C9A]" end}><%= @bio %></h2>
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
    <a href={"https://github.com/" <> company_link} target="_blank">
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
    <a href={@website} target="_blank"><%= @website %></a>
    """
  end

  def location(%{location: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def location(assigns) do
    ~H"""
    <h2><%= @location %></h2>
    """
  end

  def twitter_link(%{twitter: nil} = assigns) do
    ~H"""
    <h2 class="text-[#697C9A]">Not available</h2>
    """
  end

  def twitter_link(assigns) do
    ~H"""
    <a href={"https://twitter.com/" <> @twitter} target="_blank">
      <%= @twitter %>
    </a>
    """
  end
end
