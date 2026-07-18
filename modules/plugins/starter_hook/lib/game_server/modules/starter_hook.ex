defmodule GameServer.Modules.StarterHook do
  @moduledoc """
  Example hooks plugin.

  `use GameServer.Hooks` pulls in default (no-op) implementations for every
  lifecycle callback, so you only override the ones you care about. This module
  shows a few common patterns:

    * overriding a lifecycle callback (`after_user_register/1`)
    * a plain "hello world" custom RPC (`hello/1`)
    * reading the calling user (`whoami/0`, `set_current_user_meta/2`)

  Any public function is callable by name from a client, e.g.
  `starter_hook.hello("World")` — no registration needed.

  The plugin is loaded from `GAME_SERVER_PLUGINS_DIR` (default `modules/plugins`).
  After editing, reload it from Admin → Config (or restart the server).
  """

  use GameServer.Hooks

  alias GameServer.Accounts
  alias GameServer.Hooks

  # --- Lifecycle hook -------------------------------------------------------
  # Override any callback declared in GameServer.Hooks. Here we grant every new
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
  it instead of reading `Process.get(:game_server_hook_caller)` directly, since
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
