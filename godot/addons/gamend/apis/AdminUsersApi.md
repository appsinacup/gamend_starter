<a name="__pageTop"></a>
# AdminUsersApi   { #AdminUsersApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_delete_user**](#admin_delete_user) | **DELETE** `/api/v1/admin/users/{id}` | Delete user (admin)
[**admin_update_user**](#admin_update_user) | **PATCH** `/api/v1/admin/users/{id}` | Update user (admin)

# **admin_delete_user**   { #admin_delete_user }
<a name="admin_delete_user"></a>

> `admin_delete_user(id: int, on_success: Callable, on_failure: Callable)`

Delete user (admin)



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
var api = AdminUsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminUsersApi.new(config, client)


# Invoke an endpoint
api.admin_delete_user(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_user", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_update_user**   { #admin_update_user }
<a name="admin_update_user"></a>

> `admin_update_user(id: int,adminUpdateUserRequest = null, on_success: Callable, on_failure: Callable)`

Update user (admin)



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
var api = AdminUsersApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminUsersApi.new(config, client)

var adminUpdateUserRequest = AdminUpdateUserRequest.new()
# … fill model adminUpdateUserRequest with data

# Invoke an endpoint
api.admin_update_user(
	# id: int   Eg: 56
	id,
	# adminUpdateUserRequest: AdminUpdateUserRequest
	# User patch
	adminUpdateUserRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_update_user", response)
		assert(response.data is admin_update_user_200_response)
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

