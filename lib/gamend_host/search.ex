defmodule GamendHost.Search do
  @moduledoc """
  What the site search palette finds on this host.

  Core owns the palette — the button, the dialog, the ranking, the keyboard —
  and this owns the catalogue. Without a provider the palette still works and
  finds every navigation destination; this adds the content behind those
  links, so a post is findable by its own title rather than only through the
  `/blog` link that lists it.

  This is the shape to copy when you add content of your own: start from
  `SearchIndex.navigation_entries/1`, append one list per collection, and give
  each list a `group` heading. The navigation goes first because
  `GamendWeb.SearchIndex` dedupes by href and keeps the first row it saw.

  Guides are absent because this host registers no `:docs` collection and
  routes no `/docs/:slug`. Add both together — an entry pointing at a route
  that does not exist is a row that 404s, and `test/search_test.exs` resolves
  every href through the real router to catch exactly that.
  """

  @behaviour GamendWeb.SearchIndex.Provider

  # This host has no gettext backend of its own, so it borrows gamend_web's:
  # "Blog", "Changelog" and "Roadmap" are core's page titles, translated there
  # and in the reader's locale by the time `entries/1` runs. "About" and
  # "Pages" are this host's own words and stay English until it adds a backend
  # — then point this at it and wrap those two as well.
  use Gettext, backend: GamendWeb.Gettext

  alias Gamend.Content
  alias GamendWeb.SearchIndex

  @pages_group "Pages"

  @impl true
  def entries(context) do
    SearchIndex.navigation_entries(context) ++ page_entries() ++ blog_entries()
  end

  # Routed by `GamendHost.Router` but absent from the theme's navigation, so
  # the nav sweep cannot find them. A page nobody links to is exactly the page
  # worth being able to search for. Listing one the nav *does* carry costs
  # nothing — `GamendWeb.SearchIndex` dedupes by href and the nav row, which
  # comes first, is the one that survives.
  defp page_entries do
    [
      {"About", "/about"},
      {gettext("Blog"), "/blog"},
      {gettext("Changelog"), "/changelog"},
      {gettext("Roadmap"), "/roadmap"}
    ]
    |> Enum.map(fn {title, href} -> %{title: title, href: href, group: @pages_group} end)
  end

  # The date and not the excerpt: the subtitle is the truncated right-hand half
  # of a row, and half of a first sentence tells a reader less than knowing
  # which post is the recent one.
  defp blog_entries do
    Enum.map(Content.list_blog_posts(), fn post ->
      %{
        title: post.title,
        href: "/blog/#{post.slug}",
        group: gettext("Blog"),
        subtitle: blog_date(post)
      }
    end)
  end

  defp blog_date(%{date: %Date{} = date}), do: Date.to_iso8601(date)
  defp blog_date(_post), do: nil
end
