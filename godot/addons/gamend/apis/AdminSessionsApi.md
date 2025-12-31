<a name="__pageTop"></a>
# AdminSessionsApi   { #AdminSessionsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_delete_session**](#admin_delete_session) | **DELETE** `/api/v1/admin/sessions/{id}` | Delete session token by id (admin)
[**admin_delete_user_sessions**](#admin_delete_user_sessions) | **DELETE** `/api/v1/admin/users/{id}/sessions` | Delete all session tokens for a user (admin)
[**admin_list_sessions**](#admin_list_sessions) | **GET** `/api/v1/admin/sessions` | List sessions (admin)

# **admin_delete_session**   { #admin_delete_session }
<a name="admin_delete_session"></a>

> `admin_delete_session(id: int, on_success: Callable, on_failure: Callable)`

Delete session token by id (admin)



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
var api = AdminSessionsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminSessionsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_session(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_session", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_user_sessions**   { #admin_delete_user_sessions }
<a name="admin_delete_user_sessions"></a>

> `admin_delete_user_sessions(id: int, on_success: Callable, on_failure: Callable)`

Delete all session tokens for a user (admin)



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
var api = AdminSessionsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminSessionsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_user_sessions(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_user_sessions", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_list_sessions**   { #admin_list_sessions }
<a name="admin_list_sessions"></a>

> `admin_list_sessions(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List sessions (admin)



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
var api = AdminSessionsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminSessionsApi.new(config, client)


# Invoke an endpoint
api.admin_list_sessions(
	# page: int   Eg: 56
	page,
	# pageSize: int   Eg: 56
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_list_sessions", response)
		assert(response.data is admin_list_sessions_200_response)
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

