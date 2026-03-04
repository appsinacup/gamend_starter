class_name GamendServerTest
extends GamendServer

@export var gamend_api: GamendApi
@export var text_edit: TextEdit

func _ready():
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

# Callbacks
func _after_user_login(user: Dictionary):
	print("after_user_login: ", user)

func _after_startup():
	print("Received after_startup")

# RPC's
func new_func(arg: String):
	print("new_func: ", arg)
	#var adminCreateKvEntryRequest:= AdminCreateKvEntryRequest.new()
	#adminCreateKvEntryRequest.key = "123"
	#adminCreateKvEntryRequest.data = {"a": 123}
	#await gamend_api.admin_kv_admin_upsert_kv(adminCreateKvEntryRequest)
	#var res :GamendResult = await gamend_api.kv_get_kv("123")
	#print(JSON.stringify(res.response.data.data))
	return arg + "abc" #+ JSON.stringify(res.response.data.data)
