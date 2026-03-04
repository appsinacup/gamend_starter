extends Node2D

var gamend_api: GamendApi
@export var text_edit: TextEdit

func _ready():
	gamend_api = GamendApi.new("gamend.appsinacup.com", 443, true)
	add_child(gamend_api)
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
