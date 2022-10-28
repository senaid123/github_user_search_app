defmodule GithubUserSearchAppWeb.GithubUserSearchAppWebTest do
  use GithubUserSearchAppWeb.ConnCase

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  describe "user search page" do
    test "user can see content on the page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.github_user_index_path(conn, :index))

      assert has_element?(index_live, "#user-search")
      assert has_element?(index_live, "#user-name")
      assert has_element?(index_live, "#form", "")
      assert has_element?(index_live, "button", "Search")
      assert has_element?(index_live, "h2", "Octocat")
    end
  end

  describe "user page after search" do
    test "user can search github account", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.github_user_index_path(conn, :index))

      assert has_element?(index_live, "h2", "Octocat")
      assert has_element?(index_live, "a", "octocat")

      index_live
      |> form("#form", %{search: "senaid123"})
      |> render_submit()

      assert has_element?(index_live, "h2", "Senaid Karauzovic")
      assert has_element?(index_live, "a", "senaid123")
    end
  end

  describe "user gets no results after invalid search" do
    test "users try to invalid search", %{conn: conn} do
      {ok, index_live, _html} = live(conn, Routes.github_user_index_path(conn, :index))

      refute has_element?(index_live, "#not-found")

      index_live
      |> form("#form", %{search: "oioeiwori234i324o"})
      |> render_submit()

      assert has_element?(index_live, "#not-found")
    end
  end

  describe "user change background" do
    test "user click on light toggle area", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.github_user_index_path(conn, :index))

      assert has_element?(index_live, ".background")
      assert has_element?(index_live, "#dark")

      index_live
      |> element("#toggle-bar")
      |> render_click()

      assert has_element?(index_live, ".bg-white")
      assert has_element?(index_live, "#light")
    end
  end
end
