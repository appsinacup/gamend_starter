class_name GamendServerTest
extends GamendServer

@export var gamend_api: GamendApi

func _ready():
	gamend_api = GamendApi.new()
	await gamend_api.authenticate_device_login("random_string")
	var health_result = await gamend_api.health_index()
	print(health_result.response.data.status)

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
