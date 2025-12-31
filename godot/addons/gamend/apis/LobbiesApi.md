<a name="__pageTop"></a>
# LobbiesApi   { #LobbiesApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_lobby**](#create_lobby) | **POST** `/api/v1/lobbies` | Create a lobby
[**join_lobby**](#join_lobby) | **POST** `/api/v1/lobbies/{id}/join` | Join a lobby
[**kick_user**](#kick_user) | **POST** `/api/v1/lobbies/kick` | Kick a user from the lobby (host only)
[**leave_lobby**](#leave_lobby) | **POST** `/api/v1/lobbies/leave` | Leave the current lobby
[**list_lobbies**](#list_lobbies) | **GET** `/api/v1/lobbies` | List lobbies
[**quick_join**](#quick_join) | **POST** `/api/v1/lobbies/quick_join` | Quick-join or create a lobby
[**update_lobby**](#update_lobby) | **PATCH** `/api/v1/lobbies` | Update lobby (host only)

# **create_lobby**   { #create_lobby }
<a name="create_lobby"></a>

> `create_lobby(createLobbyRequest = null, on_success: Callable, on_failure: Callable)`

Create a lobby

Create a new lobby. The authenticated user becomes the host and is automatically joined.

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
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)

var createLobbyRequest = CreateLobbyRequest.new()
# … fill model createLobbyRequest with data

# Invoke an endpoint
api.create_lobby(
	# createLobbyRequest: CreateLobbyRequest
	# Lobby creation parameters
	createLobbyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "create_lobby", response)
		assert(response.data is list_lobbies_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **join_lobby**   { #join_lobby }
<a name="join_lobby"></a>

> `join_lobby(id: int,joinLobbyRequest = null, on_success: Callable, on_failure: Callable)`

Join a lobby

Join an existing lobby. If the lobby requires a password, include it in the request body.

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
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)

var joinLobbyRequest = JoinLobbyRequest.new()
# … fill model joinLobbyRequest with data

# Invoke an endpoint
api.join_lobby(
	# id: int   Eg: 56
	# Lobby ID
	id,
	# joinLobbyRequest: JoinLobbyRequest
	# Join parameters (optional)
	joinLobbyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "join_lobby", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **kick_user**   { #kick_user }
<a name="kick_user"></a>

> `kick_user(kickUserRequest = null, on_success: Callable, on_failure: Callable)`

Kick a user from the lobby (host only)

Remove a user from the lobby. Only the host can kick users via the API (returns 403 if not host).

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
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)

var kickUserRequest = KickUserRequest.new()
# … fill model kickUserRequest with data

# Invoke an endpoint
api.kick_user(
	# kickUserRequest: KickUserRequest
	# Kick parameters
	kickUserRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "kick_user", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **leave_lobby**   { #leave_lobby }
<a name="leave_lobby"></a>

> `leave_lobby( on_success: Callable, on_failure: Callable)`

Leave the current lobby

Leave the lobby you are currently in.

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
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)


# Invoke an endpoint
api.leave_lobby(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "leave_lobby", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_lobbies**   { #list_lobbies }
<a name="list_lobbies"></a>

> `list_lobbies(title = "",isPassworded = "",isLocked = "",minUsers = null,maxUsers = null,page = null,pageSize = null,metadataKey = "",metadataValue = "", on_success: Callable, on_failure: Callable)`

List lobbies

Return all non-hidden lobbies. Supports optional text search via 'title', metadata filters, password/lock filters, and numeric min/max for max_users.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)


# Invoke an endpoint
api.list_lobbies(
	# title: String = ""   Eg: title_example
	# Search term for title
	title,
	# isPassworded: String = ""   Eg: isPassworded_example
	# Filter by passworded lobbies - 'true' or 'false' (omit for any)
	isPassworded,
	# isLocked: String = ""   Eg: isLocked_example
	# Filter by locked status - 'true' or 'false' (omit for any)
	isLocked,
	# minUsers: int   Eg: 56
	# Minimum max_users to include
	minUsers,
	# maxUsers: int   Eg: 56
	# Maximum max_users to include
	maxUsers,
	# page: int   Eg: 56
	# Page number (1-based)
	page,
	# pageSize: int   Eg: 56
	# Page size (max results per page)
	pageSize,
	# metadataKey: String = ""   Eg: metadataKey_example
	# Optional metadata key to filter by
	metadataKey,
	# metadataValue: String = ""   Eg: metadataValue_example
	# Optional metadata value to match (used with metadata_key)
	metadataValue,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_lobbies", response)
		assert(response.data is list_lobbies_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **quick_join**   { #quick_join }
<a name="quick_join"></a>

> `quick_join(quickJoinRequest = null, on_success: Callable, on_failure: Callable)`

Quick-join or create a lobby

Attempt to find an open, non-passworded lobby that matches the provided criteria and join it; if none found, create a new lobby. The authenticated user will become the host when a lobby is created.

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
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)

var quickJoinRequest = QuickJoinRequest.new()
# … fill model quickJoinRequest with data

# Invoke an endpoint
api.quick_join(
	# quickJoinRequest: QuickJoinRequest
	# Quick join parameters
	quickJoinRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "quick_join", response)
		assert(response.data is list_lobbies_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **update_lobby**   { #update_lobby }
<a name="update_lobby"></a>

> `update_lobby(updateLobbyRequest = null, on_success: Callable, on_failure: Callable)`

Update lobby (host only)

Update lobby settings. Only the host can update the lobby via the API (returns 403 if not host). Admins can still modify lobbies from the admin console - those changes are broadcast to viewers.

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
var api = LobbiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LobbiesApi.new(config, client)

var updateLobbyRequest = UpdateLobbyRequest.new()
# … fill model updateLobbyRequest with data

# Invoke an endpoint
api.update_lobby(
	# updateLobbyRequest: UpdateLobbyRequest
	# Lobby update parameters
	updateLobbyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "update_lobby", response)
		assert(response.data is list_lobbies_200_response_data_inner)
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

