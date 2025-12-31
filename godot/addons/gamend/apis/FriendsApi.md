<a name="__pageTop"></a>
# FriendsApi   { #FriendsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accept_friend_request**](#accept_friend_request) | **POST** `/api/v1/friends/{id}/accept` | Accept a friend request
[**block_friend_request**](#block_friend_request) | **POST** `/api/v1/friends/{id}/block` | Block a friend request / user
[**create_friend_request**](#create_friend_request) | **POST** `/api/v1/friends` | Send a friend request
[**list_blocked_friends**](#list_blocked_friends) | **GET** `/api/v1/me/blocked` | List users you&#x27;ve blocked
[**list_friend_requests**](#list_friend_requests) | **GET** `/api/v1/me/friend-requests` | List pending friend requests (incoming and outgoing)
[**list_friends**](#list_friends) | **GET** `/api/v1/me/friends` | List current user&#x27;s friends (returns a paginated set of user objects)
[**reject_friend_request**](#reject_friend_request) | **POST** `/api/v1/friends/{id}/reject` | Reject a friend request
[**remove_friendship**](#remove_friendship) | **DELETE** `/api/v1/friends/{id}` | Remove/cancel a friendship or request
[**unblock_friend**](#unblock_friend) | **POST** `/api/v1/friends/{id}/unblock` | Unblock a previously-blocked friendship

# **accept_friend_request**   { #accept_friend_request }
<a name="accept_friend_request"></a>

> `accept_friend_request(id: int, on_success: Callable, on_failure: Callable)`

Accept a friend request



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.accept_friend_request(
	# id: int   Eg: 56
	# Friendship record id (friendship_id) - the id of the friendship row, not a user id
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "accept_friend_request", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **block_friend_request**   { #block_friend_request }
<a name="block_friend_request"></a>

> `block_friend_request(id: int, on_success: Callable, on_failure: Callable)`

Block a friend request / user



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.block_friend_request(
	# id: int   Eg: 56
	# Friendship record id (friendship_id) - the id of the friendship row, not a user id
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "block_friend_request", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **create_friend_request**   { #create_friend_request }
<a name="create_friend_request"></a>

> `create_friend_request(createFriendRequestRequest = null, on_success: Callable, on_failure: Callable)`

Send a friend request



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)

var createFriendRequestRequest = CreateFriendRequestRequest.new()
# … fill model createFriendRequestRequest with data

# Invoke an endpoint
api.create_friend_request(
	# createFriendRequestRequest: CreateFriendRequestRequest
	# Friend request
	createFriendRequestRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "create_friend_request", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_blocked_friends**   { #list_blocked_friends }
<a name="list_blocked_friends"></a>

> `list_blocked_friends(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List users you've blocked



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.list_blocked_friends(
	# page: int   Eg: 56
	# Page number (1-based)
	page,
	# pageSize: int   Eg: 56
	# Page size (max results per page)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_blocked_friends", response)
		assert(response.data is list_blocked_friends_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_friend_requests**   { #list_friend_requests }
<a name="list_friend_requests"></a>

> `list_friend_requests(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List pending friend requests (incoming and outgoing)



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.list_friend_requests(
	# page: int   Eg: 56
	# Page number (1-based, applied to both lists)
	page,
	# pageSize: int   Eg: 56
	# Page size (applied to both lists)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_friend_requests", response)
		assert(response.data is list_friend_requests_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_friends**   { #list_friends }
<a name="list_friends"></a>

> `list_friends(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List current user's friends (returns a paginated set of user objects)



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.list_friends(
	# page: int   Eg: 56
	# Page number (1-based)
	page,
	# pageSize: int   Eg: 56
	# Page size (max results per page)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_friends", response)
		assert(response.data is list_friends_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **reject_friend_request**   { #reject_friend_request }
<a name="reject_friend_request"></a>

> `reject_friend_request(id: int, on_success: Callable, on_failure: Callable)`

Reject a friend request



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.reject_friend_request(
	# id: int   Eg: 56
	# Friendship record id (friendship_id) - the id of the friendship row, not a user id
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "reject_friend_request", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **remove_friendship**   { #remove_friendship }
<a name="remove_friendship"></a>

> `remove_friendship(id: int, on_success: Callable, on_failure: Callable)`

Remove/cancel a friendship or request



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.remove_friendship(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "remove_friendship", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **unblock_friend**   { #unblock_friend }
<a name="unblock_friend"></a>

> `unblock_friend(id: int, on_success: Callable, on_failure: Callable)`

Unblock a previously-blocked friendship



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
var api = FriendsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = FriendsApi.new(config, client)


# Invoke an endpoint
api.unblock_friend(
	# id: int   Eg: 56
	# Friendship record id (friendship_id) - the id of the friendship row, not a user id
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "unblock_friend", response)
		assert(response.data is )
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

