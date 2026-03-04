<a name="__pageTop"></a>
# PartiesApi   { #PartiesApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_party**](#create_party) | **POST** `/api/v1/parties` | Create a party
[**join_party_by_code**](#join_party_by_code) | **POST** `/api/v1/parties/join` | Join a party by code
[**kick_party_member**](#kick_party_member) | **POST** `/api/v1/parties/kick` | Kick a member from the party (leader only)
[**leave_party**](#leave_party) | **POST** `/api/v1/parties/leave` | Leave the current party
[**party_create_lobby**](#party_create_lobby) | **POST** `/api/v1/parties/create_lobby` | Create a lobby with the party (leader only)
[**party_join_lobby**](#party_join_lobby) | **POST** `/api/v1/parties/join_lobby/{id}` | Join a lobby with the party (leader only)
[**show_party**](#show_party) | **GET** `/api/v1/parties/me` | Get current party
[**update_party**](#update_party) | **PATCH** `/api/v1/parties` | Update party settings (leader only)

# **create_party**   { #create_party }
<a name="create_party"></a>

> `create_party(createPartyRequest = null, on_success: Callable, on_failure: Callable)`

Create a party

Create a new party. The authenticated user becomes the leader and first member. Cannot create a party while already in a party.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)

var createPartyRequest = CreatePartyRequest.new()
# … fill model createPartyRequest with data

# Invoke an endpoint
api.create_party(
	# createPartyRequest: CreatePartyRequest
	# Party creation parameters
	createPartyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "create_party", response)
		assert(response.data is show_party_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **join_party_by_code**   { #join_party_by_code }
<a name="join_party_by_code"></a>

> `join_party_by_code(joinPartyByCodeRequest = null, on_success: Callable, on_failure: Callable)`

Join a party by code

Join a party using its unique 6-character code. The code is case-insensitive. If you are already in a party, you will automatically leave it first (disbanding it if you are the leader).

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)

var joinPartyByCodeRequest = JoinPartyByCodeRequest.new()
# … fill model joinPartyByCodeRequest with data

# Invoke an endpoint
api.join_party_by_code(
	# joinPartyByCodeRequest: JoinPartyByCodeRequest
	# Join parameters
	joinPartyByCodeRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "join_party_by_code", response)
		assert(response.data is show_party_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **kick_party_member**   { #kick_party_member }
<a name="kick_party_member"></a>

> `kick_party_member(kickUserRequest = null, on_success: Callable, on_failure: Callable)`

Kick a member from the party (leader only)

Remove a member from the party. Only the party leader can kick members.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)

var kickUserRequest = KickUserRequest.new()
# … fill model kickUserRequest with data

# Invoke an endpoint
api.kick_party_member(
	# kickUserRequest: KickUserRequest
	# Kick parameters
	kickUserRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "kick_party_member", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **leave_party**   { #leave_party }
<a name="leave_party"></a>

> `leave_party( on_success: Callable, on_failure: Callable)`

Leave the current party

Leave the party you are currently in. If you are the leader, the party is disbanded and all members are removed.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)


# Invoke an endpoint
api.leave_party(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "leave_party", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **party_create_lobby**   { #party_create_lobby }
<a name="party_create_lobby"></a>

> `party_create_lobby(partyCreateLobbyRequest = null, on_success: Callable, on_failure: Callable)`

Create a lobby with the party (leader only)

The party leader creates a new lobby and all party members join it atomically. The party is kept intact. No party member may already be in a lobby. The lobby must have enough capacity for all party members.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)

var partyCreateLobbyRequest = PartyCreateLobbyRequest.new()
# … fill model partyCreateLobbyRequest with data

# Invoke an endpoint
api.party_create_lobby(
	# partyCreateLobbyRequest: PartyCreateLobbyRequest
	# Lobby creation parameters
	partyCreateLobbyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "party_create_lobby", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **party_join_lobby**   { #party_join_lobby }
<a name="party_join_lobby"></a>

> `party_join_lobby(id: int,partyJoinLobbyRequest = null, on_success: Callable, on_failure: Callable)`

Join a lobby with the party (leader only)

The party leader joins an existing lobby and all party members join atomically. The party is kept intact. No party member may already be in a lobby. The lobby must have enough free space for all party members.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)

var partyJoinLobbyRequest = PartyJoinLobbyRequest.new()
# … fill model partyJoinLobbyRequest with data

# Invoke an endpoint
api.party_join_lobby(
	# id: int   Eg: 56
	# Lobby ID
	id,
	# partyJoinLobbyRequest: PartyJoinLobbyRequest
	# Join parameters (optional)
	partyJoinLobbyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "party_join_lobby", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **show_party**   { #show_party }
<a name="show_party"></a>

> `show_party( on_success: Callable, on_failure: Callable)`

Get current party

Get the party the authenticated user is currently in, including members.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)


# Invoke an endpoint
api.show_party(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "show_party", response)
		assert(response.data is show_party_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **update_party**   { #update_party }
<a name="update_party"></a>

> `update_party(updatePartyRequest = null, on_success: Callable, on_failure: Callable)`

Update party settings (leader only)

Update party settings such as max_size and metadata. Only the leader can update.

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
var api = PartiesApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = PartiesApi.new(config, client)

var updatePartyRequest = UpdatePartyRequest.new()
# … fill model updatePartyRequest with data

# Invoke an endpoint
api.update_party(
	# updatePartyRequest: UpdatePartyRequest
	# Party update parameters
	updatePartyRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "update_party", response)
		assert(response.data is show_party_200_response)
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

