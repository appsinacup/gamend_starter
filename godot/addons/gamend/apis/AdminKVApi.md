<a name="__pageTop"></a>
# AdminKVApi   { #AdminKVApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_create_kv_entry**](#admin_create_kv_entry) | **POST** `/api/v1/admin/kv/entries` | Create KV entry (admin)
[**admin_delete_kv**](#admin_delete_kv) | **DELETE** `/api/v1/admin/kv` | Delete KV by key (admin)
[**admin_delete_kv_entry**](#admin_delete_kv_entry) | **DELETE** `/api/v1/admin/kv/entries/{id}` | Delete KV entry by id (admin)
[**admin_list_kv_entries**](#admin_list_kv_entries) | **GET** `/api/v1/admin/kv/entries` | List KV entries (admin)
[**admin_update_kv_entry**](#admin_update_kv_entry) | **PATCH** `/api/v1/admin/kv/entries/{id}` | Update KV entry by id (admin)
[**admin_upsert_kv**](#admin_upsert_kv) | **PUT** `/api/v1/admin/kv` | Upsert KV by key (admin)

# **admin_create_kv_entry**   { #admin_create_kv_entry }
<a name="admin_create_kv_entry"></a>

> `admin_create_kv_entry(adminCreateKvEntryRequest = null, on_success: Callable, on_failure: Callable)`

Create KV entry (admin)



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
var api = AdminKVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminKVApi.new(config, client)

var adminCreateKvEntryRequest = AdminCreateKvEntryRequest.new()
# … fill model adminCreateKvEntryRequest with data

# Invoke an endpoint
api.admin_create_kv_entry(
	# adminCreateKvEntryRequest: AdminCreateKvEntryRequest
	# KV entry
	adminCreateKvEntryRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_create_kv_entry", response)
		assert(response.data is admin_create_kv_entry_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_kv**   { #admin_delete_kv }
<a name="admin_delete_kv"></a>

> `admin_delete_kv(key: String,userId = null, on_success: Callable, on_failure: Callable)`

Delete KV by key (admin)



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
var api = AdminKVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminKVApi.new(config, client)


# Invoke an endpoint
api.admin_delete_kv(
	# key: String = ""   Eg: key_example
	key,
	# userId: int   Eg: 56
	userId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_kv", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_kv_entry**   { #admin_delete_kv_entry }
<a name="admin_delete_kv_entry"></a>

> `admin_delete_kv_entry(id: int, on_success: Callable, on_failure: Callable)`

Delete KV entry by id (admin)



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
var api = AdminKVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminKVApi.new(config, client)


# Invoke an endpoint
api.admin_delete_kv_entry(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_kv_entry", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_list_kv_entries**   { #admin_list_kv_entries }
<a name="admin_list_kv_entries"></a>

> `admin_list_kv_entries(page = null,pageSize = null,key = "",userId = null,globalOnly = "", on_success: Callable, on_failure: Callable)`

List KV entries (admin)



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
var api = AdminKVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminKVApi.new(config, client)


# Invoke an endpoint
api.admin_list_kv_entries(
	# page: int   Eg: 56
	page,
	# pageSize: int   Eg: 56
	pageSize,
	# key: String = ""   Eg: key_example
	key,
	# userId: int   Eg: 56
	userId,
	# globalOnly: String = ""   Eg: globalOnly_example
	globalOnly,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_list_kv_entries", response)
		assert(response.data is admin_list_kv_entries_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_update_kv_entry**   { #admin_update_kv_entry }
<a name="admin_update_kv_entry"></a>

> `admin_update_kv_entry(id: int,adminUpdateKvEntryRequest = null, on_success: Callable, on_failure: Callable)`

Update KV entry by id (admin)



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
var api = AdminKVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminKVApi.new(config, client)

var adminUpdateKvEntryRequest = AdminUpdateKvEntryRequest.new()
# … fill model adminUpdateKvEntryRequest with data

# Invoke an endpoint
api.admin_update_kv_entry(
	# id: int   Eg: 56
	id,
	# adminUpdateKvEntryRequest: AdminUpdateKvEntryRequest
	# KV entry patch
	adminUpdateKvEntryRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_update_kv_entry", response)
		assert(response.data is admin_create_kv_entry_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_upsert_kv**   { #admin_upsert_kv }
<a name="admin_upsert_kv"></a>

> `admin_upsert_kv(adminCreateKvEntryRequest = null, on_success: Callable, on_failure: Callable)`

Upsert KV by key (admin)



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
var api = AdminKVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminKVApi.new(config, client)

var adminCreateKvEntryRequest = AdminCreateKvEntryRequest.new()
# … fill model adminCreateKvEntryRequest with data

# Invoke an endpoint
api.admin_upsert_kv(
	# adminCreateKvEntryRequest: AdminCreateKvEntryRequest
	# KV upsert
	adminCreateKvEntryRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_upsert_kv", response)
		assert(response.data is admin_create_kv_entry_200_response)
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

