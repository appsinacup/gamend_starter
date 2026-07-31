defmodule GamendHost.Router do
  @moduledoc """
  Host-owned router.

  Core's routes come from the `GamendWeb.Router.Shared` macros; only what
  this host adds is written here. This used to be a hand-copied fork of core's
  whole route table, which drifted twice over: the admin list first (six pages
  404'd), then the route renames (`/users/log-in` et al. stayed hyphenated here
  after core moved to underscores) — and API groups added in core (economy,
  tournaments, matchmaking, push, storage, ready checks) never arrived at all.
  """

  use GamendWeb, :router

  import GamendWeb.UserAuth
  import GamendWeb.Router.Shared
  import Phoenix.LiveDashboard.Router
  import Oban.Web.Router

  gamend_pipelines()

  @require_admin_on_mount GamendWeb.Router.Shared.require_admin_on_mount()
  @require_authenticated_on_mount GamendWeb.Router.Shared.require_authenticated_on_mount()
  @current_user_on_mount GamendWeb.Router.Shared.current_user_on_mount()

  scope "/content", GamendWeb do
    get "/:type/*path", HostContentAssetController, :show
  end

  scope "/" do
    pipe_through :browser

    get "/sitemap.xml", GamendHost.SitemapController, :index
  end

  gamend_static_page_routes()
  gamend_api_routes()
  gamend_support_routes()
  gamend_admin_live_routes(@require_admin_on_mount)
  gamend_authenticated_live_routes(@require_authenticated_on_mount)

  gamend_current_user_routes(@current_user_on_mount,
    changelog: HostChangelogLive,
    roadmap: HostRoadmapLive,
    blog: HostBlogLive,
    do: live("/about", HostAboutLive, :index)
  )

  gamend_oauth_routes()
  gamend_configured_page_fallback_routes()
end
