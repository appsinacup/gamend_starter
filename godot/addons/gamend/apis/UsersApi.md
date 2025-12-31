<a name="__pageTop"></a>
# UsersApi   { #UsersApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_current_user**](#delete_current_user) | **DELETE** `/api/v1/me` | Delete current user
[**get_current_user**](#get_current_user) | **GET** `/api/v1/me` | Return current user info
[**get_user**](#get_user) | **GET** `/api/v1/users/{id}` | Get a user by id
[**search_users**](#search_users) | **GET** `/api/v1/users` | Search users by id/email/display_name
[**update_current_user_display_name**](#update_current_user_display_name) | **PATCH** `/api/v1/me/display_name` | Update current user&#x27;s display name
[**update_current_user_password**](#update_current_user_password) | **PATCH** `/api/v1/me/password` | Update current user password

# **delete_current_user**   { #delete_current_user }
<a name="delete_current_user"></a>

> `delete_current_user( on_success: Callable, on_failure: Callable)`

Delete current user

Deletes the authenticated user's account

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
var api = UsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = UsersApi.new(config, client)


# Invoke an endpoint
api.delete_current_user(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "delete_current_user", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **get_current_user**   { #get_current_user }
<a name="get_current_user"></a>

> `get_current_user( on_success: Callable, on_failure: Callable)`

Return current user info

Returns the current authenticated user's basic information.

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
var api = UsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = UsersApi.new(config, client)


# Invoke an endpoint
api.get_current_user(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_current_user", response)
		assert(response.data is get_current_user_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **get_user**   { #get_user }
<a name="get_user"></a>

> `get_user(id: int, on_success: Callable, on_failure: Callable)`

Get a user by id



### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = UsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = UsersApi.new(config, client)


# Invoke an endpoint
api.get_user(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_user", response)
		assert(response.data is search_users_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **search_users**   { #search_users }
<a name="search_users"></a>

> `search_users(q = "",page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

Search users by id/email/display_name



### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = UsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = UsersApi.new(config, client)


# Invoke an endpoint
api.search_users(
	# q: String = ""   Eg: q_example
	q,
	# page: int   Eg: 56
	page,
	# pageSize: int   Eg: 56
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "search_users", response)
		assert(response.data is search_users_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **update_current_user_display_name**   { #update_current_user_display_name }
<a name="update_current_user_display_name"></a>

> `update_current_user_display_name(updateCurrentUserDisplayNameRequest = null, on_success: Callable, on_failure: Callable)`

Update current user's display name



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
var api = UsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = UsersApi.new(config, client)

var updateCurrentUserDisplayNameRequest = UpdateCurrentUserDisplayNameRequest.new()
# … fill model updateCurrentUserDisplayNameRequest with data

# Invoke an endpoint
api.update_current_user_display_name(
	# updateCurrentUserDisplayNameRequest: UpdateCurrentUserDisplayNameRequest
	# Display name payload
	updateCurrentUserDisplayNameRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "update_current_user_display_name", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **update_current_user_password**   { #update_current_user_password }
<a name="update_current_user_password"></a>

> `update_current_user_password(updateCurrentUserPasswordRequest = null, on_success: Callable, on_failure: Callable)`

Update current user password



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
var api = UsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = UsersApi.new(config, client)

var updateCurrentUserPasswordRequest = UpdateCurrentUserPasswordRequest.new()
# … fill model updateCurrentUserPasswordRequest with data

# Invoke an endpoint
api.update_current_user_password(
	# updateCurrentUserPasswordRequest: UpdateCurrentUserPasswordRequest
	# New password payload
	updateCurrentUserPasswordRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "update_current_user_password", response)
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

