<a name="__pageTop"></a>
# AdminLobbiesApi   { #AdminLobbiesApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_delete_lobby**](#admin_delete_lobby) | **DELETE** `/api/v1/admin/lobbies/{id}` | Delete lobby by id (admin)
[**admin_list_lobbies**](#admin_list_lobbies) | **GET** `/api/v1/admin/lobbies` | List all lobbies (admin)
[**admin_update_lobby**](#admin_update_lobby) | **PATCH** `/api/v1/admin/lobbies/{id}` | Update lobby by id (admin)

# **admin_delete_lobby**   { #admin_delete_lobby }
<a name="admin_delete_lobby"></a>

> `admin_delete_lobby(id: int, on_success: Callable, on_failure: Callable)`

Delete lobby by id (admin)



### Example

* Bearer (JWT) Authentication (`authorization`)

```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AdminLobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLobbiesApi.new(config, client)


# Invoke an endpoint
api.admin_delete_lobby(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_lobby", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_list_lobbies**   { #admin_list_lobbies }
<a name="admin_list_lobbies"></a>

> `admin_list_lobbies(title = "",isHidden = "",isLocked = "",hasPassword = "",minUsers = null,maxUsers = null,page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List all lobbies (admin)



### Example

* Bearer (JWT) Authentication (`authorization`)

```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AdminLobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLobbiesApi.new(config, client)


# Invoke an endpoint
api.admin_list_lobbies(
	# title: String = ""   Eg: title_example
	title,
	# isHidden: String = ""   Eg: isHidden_example
	isHidden,
	# isLocked: String = ""   Eg: isLocked_example
	isLocked,
	# hasPassword: String = ""   Eg: hasPassword_example
	hasPassword,
	# minUsers: int   Eg: 56
	minUsers,
	# maxUsers: int   Eg: 56
	maxUsers,
	# page: int   Eg: 56
	page,
	# pageSize: int   Eg: 56
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_list_lobbies", response)
		assert(response.data is admin_list_lobbies_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_update_lobby**   { #admin_update_lobby }
<a name="admin_update_lobby"></a>

> `admin_update_lobby(id: int,adminUpdateLobbyRequest = null, on_success: Callable, on_failure: Callable)`

Update lobby by id (admin)



### Example

* Bearer (JWT) Authentication (`authorization`)

```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AdminLobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLobbiesApi.new(config, client)

var adminUpdateLobbyRequest = AdminUpdateLobbyRequest.new()
# … fill model adminUpdateLobbyRequest with data

# Invoke an endpoint
api.admin_update_lobby(
	# id: int   Eg: 56
	id,
	# adminUpdateLobbyRequest: AdminUpdateLobbyRequest
	# Lobby patch
	adminUpdateLobbyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_update_lobby", response)
		assert(response.data is admin_update_lobby_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```


### Authorization

[authorization](../README.md#authorization)

[[Back to top]](#__pageTop) \
[[Back to API list]](../README.md#documentation-for-api-endpoints) \
[[Back to Model list]](../README.md#documentation-for-models) \
[[Back to README]](../README.md) \

