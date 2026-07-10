extends Node2D

## Demo client: calls the same server function (starter_hook.hello) over the
## three available transports.
##
## - HTTP:      POST /api/v1/hooks/call (stateless, no lifecycle).
## - WebSocket: "call_hook" push on the realtime user channel; Connect /
##              Disconnect manage the realtime socket.
## - WebRTC:    "call_hook" JSON on the "events" DataChannel (see server
##              webrtc_peer.ex); signaling runs over the user channel, so the
##              WebSocket must be connected first. Connect / Close manage the
##              peer connection.

const HOOK_PLUGIN := "starter_hook"
const HOOK_FN := "hello"
const HOOK_ARGS := ["World"]
## Frames to wait before giving up on channel join / WebRTC connect.
const CONNECT_TIMEOUT_FRAMES := 15 * 60

## Server to test against. Defaults to the local `mix dev.start` server; for
## production use "gamend.appsinacup.com", 443, tls = true.
@export var server_host := "localhost"
@export var server_port := 4000
@export var server_tls := false

var gamend_api: GamendApi
var webrtc: GamendWebRTC
var _user_channel: PhoenixChannel

@export var text_edit: TextEdit
@export var http_call_button: Button
@export var ws_connect_button: Button
@export var ws_disconnect_button: Button
@export var ws_call_button: Button
@export var webrtc_connect_button: Button
@export var webrtc_close_button: Button
@export var webrtc_call_button: Button

func _ready():
	gamend_api = GamendApi.new(server_host, server_port, server_tls)
	add_child(gamend_api)
	http_call_button.pressed.connect(_on_http_call_pressed)
	ws_connect_button.pressed.connect(_on_ws_connect_pressed)
	ws_disconnect_button.pressed.connect(_on_ws_disconnect_pressed)
	ws_call_button.pressed.connect(_on_ws_call_pressed)
	webrtc_connect_button.pressed.connect(_on_webrtc_connect_pressed)
	webrtc_close_button.pressed.connect(_on_webrtc_close_pressed)
	webrtc_call_button.pressed.connect(_on_webrtc_call_pressed)
	if OS.get_name() == "Web":
		print("Getting refresh token from outside")
		var refresh_token = JavaScriptBridge.eval(
            "localStorage.getItem('gamend_refresh_token') || ''"
		)
		print("Got refresh token: ", refresh_token)
		var auth_response :GamendResult = await gamend_api.authenticate_refresh_token(refresh_token)
		if auth_response.error:
			text_edit.text = auth_response.error.message
			return
	else:
		print("Using device auth")
		var auth_response :GamendResult = await gamend_api.authenticate_device_login(OS.get_unique_id())
		if auth_response.error:
			text_edit.text = auth_response.error.message
			return
	var response :GamendResult = await gamend_api.users_get_current_user()
	if response.error:
		text_edit.text = response.error.message
		return
	text_edit.text = response.response.body

func _show(message: String) -> void:
	text_edit.text = message

# ── HTTP ─────────────────────────────────────────────────────────────────────

func _on_http_call_pressed() -> void:
	http_call_button.disabled = true
	_show("HTTP: calling %s.%s%s..." % [HOOK_PLUGIN, HOOK_FN, str(HOOK_ARGS)])
	var request := CallHookRequest.new()
	request.plugin = HOOK_PLUGIN
	request.fn = HOOK_FN
	request.args = HOOK_ARGS
	var result :GamendResult = await gamend_api.hooks_call_hook(request)
	if result.error:
		_show("HTTP: error: %s" % str(result.error.message))
	else:
		_show("HTTP: reply:\n%s" % str(result.response.body))
	http_call_button.disabled = false

# ── WebSocket ────────────────────────────────────────────────────────────────

func ws_connected() -> bool:
	return _user_channel != null and is_instance_valid(_user_channel) and _user_channel.is_joined()

func _on_ws_connect_pressed() -> void:
	if ws_connected():
		_show("WS: already connected.")
		return
	ws_connect_button.disabled = true
	_show("WS: connecting realtime socket...")
	_user_channel = null
	await gamend_api.realtime_start()
	var channel: PhoenixChannel = gamend_api.get_user_channel()
	channel.on_event.connect(_on_user_channel_event)
	var timeout := CONNECT_TIMEOUT_FRAMES
	while not channel.is_joined():
		await get_tree().process_frame
		timeout -= 1
		if timeout <= 0:
			_show("WS: timed out joining the user channel.")
			ws_connect_button.disabled = false
			return
	_user_channel = channel
	_show("WS: connected, user channel joined.")
	ws_connect_button.disabled = false

func _on_ws_disconnect_pressed() -> void:
	# WebRTC signals over this socket, so close the peer connection first.
	if webrtc:
		_close_webrtc()
	gamend_api.realtime_stop()
	_user_channel = null
	_show("WS: disconnected.")

func _on_ws_call_pressed() -> void:
	if not ws_connected():
		_show("WS: not connected — press Connect first.")
		return
	_show("WS: calling %s.%s%s..." % [HOOK_PLUGIN, HOOK_FN, str(HOOK_ARGS)])
	var pushed := _user_channel.push("call_hook", {
		"plugin": HOOK_PLUGIN, "fn": HOOK_FN, "args": HOOK_ARGS
	})
	if not pushed:
		_show("WS: push failed (channel not ready).")

## The reply to a "call_hook" push arrives as an on_event with the same event
## name (the addon maps Phoenix reply refs back to the pushed event).
func _on_user_channel_event(event: String, payload, status) -> void:
	if event != "call_hook":
		return
	if status == "ok":
		_show("WS: reply:\n%s" % JSON.stringify(payload))
	else:
		_show("WS: error (%s):\n%s" % [str(status), JSON.stringify(payload)])

# ── WebRTC ───────────────────────────────────────────────────────────────────

func webrtc_connected() -> bool:
	return webrtc != null and webrtc.is_channel_open("events")

func _on_webrtc_connect_pressed() -> void:
	if webrtc_connected():
		_show("WebRTC: already connected.")
		return
	webrtc_connect_button.disabled = true
	if not ws_connected():
		_show("WebRTC: needs the WebSocket for signaling — press its Connect first.")
		webrtc_connect_button.disabled = false
		return
	if webrtc:
		_close_webrtc()
	_show("WebRTC: connecting...")
	webrtc = GamendWebRTC.new(_user_channel, {"enable_logs": true})
	webrtc.data_received.connect(_on_webrtc_data)
	add_child(webrtc)
	webrtc.connect_webrtc()
	var timeout := CONNECT_TIMEOUT_FRAMES
	while not webrtc_connected():
		await get_tree().process_frame
		timeout -= 1
		if timeout <= 0 or webrtc == null:
			_show("WebRTC: timed out establishing the connection.")
			webrtc_connect_button.disabled = false
			return
	_show("WebRTC: connected, \"events\" DataChannel open.")
	webrtc_connect_button.disabled = false

func _on_webrtc_close_pressed() -> void:
	if webrtc == null:
		_show("WebRTC: not connected.")
		return
	_close_webrtc()
	_show("WebRTC: closed.")

func _close_webrtc() -> void:
	webrtc.close_webrtc()
	webrtc.queue_free()
	webrtc = null

func _on_webrtc_call_pressed() -> void:
	if not webrtc_connected():
		_show("WebRTC: not connected — press Connect first.")
		return
	_show("WebRTC: calling %s.%s%s..." % [HOOK_PLUGIN, HOOK_FN, str(HOOK_ARGS)])
	var request := {"type": "call_hook", "plugin": HOOK_PLUGIN, "fn": HOOK_FN, "args": HOOK_ARGS}
	var err := webrtc.send_text("events", JSON.stringify(request))
	if err != OK:
		_show("WebRTC: send failed: error %d" % err)

func _on_webrtc_data(label: String, data: PackedByteArray) -> void:
	var text := data.get_string_from_utf8()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) == TYPE_DICTIONARY and parsed.get("type") == "hook_reply":
		_show("WebRTC: reply:\n%s" % str(parsed.get("data")))
	elif typeof(parsed) == TYPE_DICTIONARY and parsed.get("type") == "hook_error":
		_show("WebRTC: error: %s" % str(parsed.get("error")))
	else:
		_show("WebRTC: data on %s:\n%s" % [label, text])
