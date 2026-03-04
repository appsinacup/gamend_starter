<a name="__pageTop"></a>
# AdminGroupsApi   { #AdminGroupsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_delete_group**](#admin_delete_group) | **DELETE** `/api/v1/admin/groups/{id}` | Delete a group (admin)
[**admin_list_groups**](#admin_list_groups) | **GET** `/api/v1/admin/groups` | List all groups (admin)
[**admin_update_group**](#admin_update_group) | **PATCH** `/api/v1/admin/groups/{id}` | Update a group (admin)

# **admin_delete_group**   { #admin_delete_group }
<a name="admin_delete_group"></a>

> `admin_delete_group(id: int, on_success: Callable, on_failure: Callable)`

Delete a group (admin)

Admin-level group deletion.

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
var api = AdminGroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminGroupsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_group(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_group", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_list_groups**   { #admin_list_groups }
<a name="admin_list_groups"></a>

> `admin_list_groups(title = "",type = "",minMembers = null,maxMembers = null,sortBy = "",page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List all groups (admin)

List all groups including hidden. Supports filters.

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
var api = AdminGroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminGroupsApi.new(config, client)


# Invoke an endpoint
api.admin_list_groups(
	# title: String = ""   Eg: title_example
	title,
	# type: String = ""   Eg: type_example
	type,
	# minMembers: int   Eg: 56
	minMembers,
	# maxMembers: int   Eg: 56
	maxMembers,
	# sortBy: String = ""   Eg: sortBy_example
	sortBy,
	# page: int   Eg: 56
	page,
	# pageSize: int   Eg: 56
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_list_groups", response)
		assert(response.data is admin_list_groups_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_update_group**   { #admin_update_group }
<a name="admin_update_group"></a>

> `admin_update_group(id: int,adminUpdateGroupRequest = null, on_success: Callable, on_failure: Callable)`

Update a group (admin)

Admin-level group update. No membership check.

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
var api = AdminGroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminGroupsApi.new(config, client)

var adminUpdateGroupRequest = AdminUpdateGroupRequest.new()
# … fill model adminUpdateGroupRequest with data

# Invoke an endpoint
api.admin_update_group(
	# id: int   Eg: 56
	id,
	# adminUpdateGroupRequest: AdminUpdateGroupRequest
	# Update parameters
	adminUpdateGroupRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_update_group", response)
		assert(response.data is admin_update_group_200_response)
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

