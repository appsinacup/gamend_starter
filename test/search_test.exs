defmodule GamendHost.SearchTest do
  @moduledoc """
  What the search palette offers, and whether those places exist.

  Every row is a promise that a URL leads somewhere, and the catalogue is
  built from two enumerations this host does not own — the theme's navigation
  and `Gamend.Content`'s blog collection. Either can gain a shape spelled
  differently from what `GamendHost.Search` assumes, and the symptom would be
  a 404 from a search result, which nobody reports as a search bug.

  So the route check is the point: every href is resolved through the real
  router, and a match against the catch-all page fallback counts as a miss,
  because that fallback matches every path ever written.
  """

  use ExUnit.Case, async: true

  alias GamendHost.Search
  alias GamendWeb.SearchIndex

  @context %{scope: nil, locale: "en"}

  defp entries, do: Search.entries(@context)

  defp resolves?("/" <> _ = href) do
    path = href |> String.split("?") |> hd()

    case Phoenix.Router.route_info(GamendHost.Router, "GET", path, "") do
      %{plug: GamendWeb.PageController, plug_opts: :configured_page} -> configured_page?(path)
      %{} -> true
      :error -> false
    end
  end

  # An off-site nav link is the theme's business, not the router's.
  defp resolves?(_href), do: true

  defp configured_page?("/" <> slug) do
    GamendWeb.HostLayouts.resolve_theme("en")
    |> Map.get("pages", %{})
    |> Map.has_key?(slug)
  end

  defp configured_page?(_path), do: false

  test "every row leads to a page that exists" do
    broken =
      entries()
      |> Enum.reject(&resolves?(&1.href))
      |> Enum.map(& &1.href)

    assert broken == []
  end

  test "nothing is offered twice" do
    hrefs = Enum.map(entries(), & &1.href)

    assert hrefs == Enum.uniq(hrefs)
  end

  test "every row says something" do
    assert Enum.all?(entries(), &(is_binary(&1.title) and String.trim(&1.title) != ""))
  end

  test "every blog post is in it" do
    posts = Enum.filter(entries(), &(&1[:group] == "Blog"))

    assert length(posts) == length(Gamend.Content.list_blog_posts())
    assert Enum.all?(posts, &String.starts_with?(&1.href, "/blog/"))
  end

  # These four are routed but not in the theme's navigation, so nothing else
  # would put them in the palette.
  test "the host's own pages are in it, nav or no nav" do
    hrefs = Enum.map(entries(), & &1.href)

    for href <- ["/about", "/blog", "/changelog", "/roadmap"] do
      assert href in hrefs
    end
  end

  test "this host is the configured provider" do
    assert SearchIndex.provider() == GamendHost.Search
  end
end
