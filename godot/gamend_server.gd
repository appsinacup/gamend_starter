extends Node2D

func after_user_login(user) -> Dictionary:
	return user

func after_startup() -> Dictionary:
	return {}

func custom_call(hook: String, args: Dictionary) -> Dictionary:
	return {}

@export var websocket_server: WebSocketServer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	websocket_server.stop()
	websocket_server.message_received.connect(_message_received)
	websocket_server.client_connected.connect(_client_connected)
	websocket_server.client_disconnected.connect(_client_disconnected)
	print("Started")
	for i in 50:
		var err = websocket_server.listen(4010)
		if err != OK:
			print("Errored: ", str(err))
		else:
			break
		await get_tree().create_timer(1.0).timeout


func _message_received(peer_id: int, message: String):
	var json = JSON.parse_string(message)
	print(json)
	print("Messaged: ", peer_id, " ", json)
	var args :Array= json.get("args", [])
	print(json.get("meta", {}).get("caller"))
	print(json.get("at"))
	var hook = json.get("hook")
	print("Hook: ", hook, " ", "args: ", args)
	match hook:
		"after_user_login":
			after_user_login(args.get(0))
		"after_startup":
			after_startup.emit()
		

func _client_connected(peer_id: int):
	print("Connected: ", peer_id)
func _client_disconnected(peer_id: int):
	print("Disconnected: ", peer_id)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST, NOTIFICATION_EXIT_TREE:
			print("Stopped")
			websocket_server.stop()
