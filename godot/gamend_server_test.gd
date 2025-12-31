class_name GamendServerTest
extends GamendServer

# Callbacks
func _after_user_login(user: Dictionary):
	print("after_user_login: ", user)

func _after_startup():
	print("after_startup")

# RPC's
func new_func(arg: String):
	print("new_func: ", arg)
	return arg + "abc"
