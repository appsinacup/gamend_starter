defmodule Gamend.Modules.StarterHook do
  @moduledoc """
  Example hooks plugin.

  `use Gamend.Hooks` pulls in default (no-op) implementations for every
  lifecycle callback, so you only override the ones you care about. This module
  shows a few common patterns:

    * demo content made at startup (`after_startup/0`): a leaderboard, quests
      and a weekly tournament, so a new server's pages show how each works
    * overriding a lifecycle callback (`after_user_register/1`)
    * a plain "hello world" custom RPC (`hello/1`)
    * reading the calling user (`whoami/0`, `set_current_user_meta/2`)
    * a server-side score submission (`submit_demo_score/1`)

  Any public function is callable by name from a client, e.g.
  `starter_hook.hello("World")` — no registration needed.

  The plugin is loaded from `GAMEND_CONTENT_PLUGINS_DIR` (default `modules/plugins`).
  After editing, reload it from Admin → Config (or restart the server).
  """

  use Gamend.Hooks

  alias Gamend.Accounts
  alias Gamend.Hooks
  alias Gamend.Leaderboards
  alias Gamend.Lock
  alias Gamend.Quests
  alias Gamend.Tournaments

  require Logger

  @demo_board "demo_scores"

  # --- Startup: demo content ------------------------------------------------
  # A new server opens with one of each, so its Leaderboards, Quests and
  # Tournaments pages show something. Only an empty server gets them (no
  # accounts, no leaderboards): a server already in use is left alone, and what
  # an admin deletes stays deleted. The lock keeps two nodes booting at once
  # from both seeding. Delete this function for a server that starts empty.
  @impl true
  def after_startup do
    Lock.exclusive("starter_hook", "demo", fn ->
      if Accounts.count_users() == 0 and Leaderboards.count_leaderboards() == 0 do
        seed_demo()
      end
    end)

    :ok
  end

  defp seed_demo do
    {:ok, board} =
      Leaderboards.create_leaderboard(%{
        slug: @demo_board,
        title: "High Scores",
        description: "A demo board: each player's best score counts.",
        operator: :best,
        sort_order: :desc
      })

    # A label board ranks names rather than players: teams, factions, countries.
    {:ok, teams} =
      Leaderboards.create_leaderboard(%{
        slug: "demo_teams",
        title: "Team Standings",
        description: "A demo board ranking teams instead of players. Points add up.",
        operator: :incr
      })

    for {team, points} <- [{"Red", 1200}, {"Blue", 950}, {"Green", 700}] do
      {:ok, _} = Leaderboards.submit_label_score(teams.id, team, points)
    end

    # Quests advance on events: `login`, `score_submitted` and `chat_message`
    # come from the server itself; a game reports its own with
    # `Quests.report_event/4`.
    {:ok, _} =
      Quests.create_quest(%{
        key: "demo_welcome",
        title: "Welcome aboard",
        description: "Log in once. Rewards are paid as soon as it is done.",
        category: "Getting started",
        objectives: [%{event: "login", target: 1}],
        rewards: [%{type: "currency", code: "gold", amount: 50}],
        auto_claim: true
      })

    {:ok, _} =
      Quests.create_quest(%{
        key: "demo_first_score",
        title: "Set a high score",
        description: "Get a score on High Scores, then claim your reward.",
        category: "Getting started",
        # `params` narrows the event to this board (its meta's `leaderboard_id`).
        objectives: [
          %{event: "score_submitted", target: 1, params: %{"leaderboard_id" => board.id}}
        ],
        rewards: [%{type: "currency", code: "gold", amount: 100}],
        prerequisite_quest_key: "demo_welcome"
      })

    {:ok, _} =
      Quests.create_quest(%{
        key: "demo_daily_chat",
        title: "Say hello",
        description: "Send 3 chat messages. Starts over every day.",
        category: "Daily",
        objectives: [%{event: "chat_message", target: 3}],
        rewards: [%{type: "currency", code: "gold", amount: 10}],
        reset: "daily"
      })

    # Registration is open from now (rather than from the ticker's next pass);
    # the draw runs at `starts_at`, and `recur` makes the next week's
    # occurrence when this one ends. Your game reports each match's winner with
    # `Tournaments.resolve_match/2`.
    {:ok, _} =
      Tournaments.create_tournament(%{
        slug: "demo_weekly_cup",
        title: "Weekly Cup",
        description: "A demo bracket for 8 players. Register now; the draw is Saturday.",
        state: "registration",
        starts_at: next_saturday_evening(),
        recur: "0 18 * * 6",
        bracket_size: 8,
        round_window_sec: 3600
      })

    Logger.info("starter_hook: made the demo leaderboards, quests and tournament")
  end

  # 18:00 UTC on the next Saturday, the time `recur` repeats. The week holding
  # tomorrow, so on a Saturday it is the one after.
  defp next_saturday_evening do
    saturday = Date.utc_today() |> Date.add(1) |> Date.end_of_week(:sunday)
    DateTime.new!(saturday, ~T[18:00:00], "Etc/UTC")
  end

  # --- Lifecycle hook -------------------------------------------------------
  # Override any callback declared in Gamend.Hooks. Here we grant every new
  # user some starting coins by writing to their metadata.
  @impl true
  def after_user_register(user) do
    Accounts.update_user(user, %{metadata: Map.put(user.metadata, "coins", 100)})
  end

  # --- Custom RPC functions -------------------------------------------------

  @doc ~s|Hello world. Call from a client as `starter_hook.hello("World")`.|
  def hello(name) when is_binary(name) do
    "Hello, " <> name <> "!"
  end

  @doc """
  Getting the current user: returns the caller's public info.

  `Hooks.caller_user/0` resolves the user for the current hook invocation — use
  it instead of reading `Process.get(:gamend_hook_caller)` directly, since
  it also resolves ids/maps to a full user struct on the server.
  """
  def whoami do
    user = Hooks.caller_user()
    {:ok, %{"id" => user.id, "display_name" => user.display_name, "metadata" => user.metadata}}
  end

  @doc """
  Returns the caller's metadata with one key set.

  This example does NOT persist; to save, call `Accounts.update_user/2` (see
  `after_user_register/1` above).
  """
  def set_current_user_meta(key, value) when is_binary(key) do
    user = Hooks.caller_user()
    {:ok, Map.put(user.metadata, key, value)}
  end

  @doc """
  Puts the caller's score on the demo High Scores board. Call from a client as
  `starter_hook.submit_demo_score(1200)`.

  Clients cannot write scores themselves: a leaderboard takes them from server
  code only. This one believes whatever number it is given, which is fine for
  a demo; your game's version decides the score from what happened in the
  match.
  """
  def submit_demo_score(score) when is_integer(score) and score >= 0 do
    user = Hooks.caller_user()
    Leaderboards.submit_score(@demo_board, user.id, score)
  end

  # --- Protobuf: typed hooks and KV schemas ---------------------------------

  @doc """
  Typed protobuf hook (see `proto/starter_hook.proto`).

  The `HelloProtoRequest`/`HelloProtoReply` message pair registers this hook's
  schema by name, so the server converts at the boundary: protobuf clients call
  it with encoded bytes, JSON clients with a plain object
  (`{"name": "x", "repeat": 2}`). This function always receives the decoded
  request struct and returns a reply struct.
  """
  def hello_proto(%StarterHook.V1.HelloProtoRequest{} = req) do
    repeat = max(req.repeat, 1)
    greeting = String.duplicate("Hello, #{req.name}! ", repeat) |> String.trim_trailing()

    %StarterHook.V1.HelloProtoReply{greeting: greeting, name_length: byte_size(req.name)}
  end

  @doc """
  KV data schemas: values stored under these keys are pushed as compact binary
  (`KvEntry.data_pb`) on protobuf sockets instead of JSON. Exact keys or
  `"prefix*"` patterns are supported.
  """
  def kv_schemas do
    %{"starter_loadout" => StarterHook.V1.StarterLoadout}
  end
end
