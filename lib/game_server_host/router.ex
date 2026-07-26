defmodule GameServerHost.Router do
  @moduledoc """
  Host-owned router.

  Core's routes come from the `GameServerWeb.Router.Shared` macros; only what
  this host adds is written here. This used to be a hand-copied fork of core's
  whole route table, which drifted twice over: the admin list first (six pages
  404'd), then the route renames (`/users/log-in` et al. stayed hyphenated here
  after core moved to underscores) — and API groups added in core (economy,
  tournaments, matchmaking, push, storage, ready checks) never arrived at all.
  """

  use GameServerWeb, :router

  import GameServerWeb.UserAuth
  import GameServerWeb.Router.Shared
  import Phoenix.LiveDashboard.Router
  import Oban.Web.Router

  game_server_pipelines()

  @require_admin_on_mount GameServerWeb.Router.Shared.require_admin_on_mount()
  @require_authenticated_on_mount GameServerWeb.Router.Shared.require_authenticated_on_mount()
  @current_user_on_mount GameServerWeb.Router.Shared.current_user_on_mount()

  scope "/content", GameServerWeb do
    get "/:type/*path", HostContentAssetController, :show
  end

  scope "/" do
    pipe_through :browser

    get "/sitemap.xml", GameServerHost.SitemapController, :index
  end

  game_server_static_page_routes()
  game_server_api_routes()
  game_server_support_routes()
  game_server_admin_live_routes(@require_admin_on_mount)
  game_server_authenticated_live_routes(@require_authenticated_on_mount)

  game_server_current_user_routes(@current_user_on_mount,
    changelog: HostChangelogLive,
    roadmap: HostRoadmapLive,
    blog: HostBlogLive,
    do: live("/about", HostAboutLive, :index)
  )

  game_server_oauth_routes()
  game_server_configured_page_fallback_routes()
end
