<a name="__pageTop"></a>
# AdminLeaderboardsApi   { #AdminLeaderboardsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_create_leaderboard**](#admin_create_leaderboard) | **POST** `/api/v1/admin/leaderboards` | Create leaderboard (admin)
[**admin_delete_leaderboard**](#admin_delete_leaderboard) | **DELETE** `/api/v1/admin/leaderboards/{id}` | Delete leaderboard (admin)
[**admin_delete_leaderboard_record**](#admin_delete_leaderboard_record) | **DELETE** `/api/v1/admin/leaderboards/{id}/records/{record_id}` | Delete leaderboard record (admin)
[**admin_delete_leaderboard_user_record**](#admin_delete_leaderboard_user_record) | **DELETE** `/api/v1/admin/leaderboards/{id}/records/user/{user_id}` | Delete a user&#x27;s record (admin)
[**admin_end_leaderboard**](#admin_end_leaderboard) | **POST** `/api/v1/admin/leaderboards/{id}/end` | End leaderboard (admin)
[**admin_submit_leaderboard_score**](#admin_submit_leaderboard_score) | **POST** `/api/v1/admin/leaderboards/{id}/records` | Submit score (admin)
[**admin_update_leaderboard**](#admin_update_leaderboard) | **PATCH** `/api/v1/admin/leaderboards/{id}` | Update leaderboard (admin)
[**admin_update_leaderboard_record**](#admin_update_leaderboard_record) | **PATCH** `/api/v1/admin/leaderboards/{id}/records/{record_id}` | Update leaderboard record (admin)

# **admin_create_leaderboard**   { #admin_create_leaderboard }
<a name="admin_create_leaderboard"></a>

> `admin_create_leaderboard(adminCreateLeaderboardRequest = null, on_success: Callable, on_failure: Callable)`

Create leaderboard (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)

var adminCreateLeaderboardRequest = AdminCreateLeaderboardRequest.new()
# … fill model adminCreateLeaderboardRequest with data

# Invoke an endpoint
api.admin_create_leaderboard(
	# adminCreateLeaderboardRequest: AdminCreateLeaderboardRequest
	# Leaderboard
	adminCreateLeaderboardRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_create_leaderboard", response)
		assert(response.data is admin_end_leaderboard_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_leaderboard**   { #admin_delete_leaderboard }
<a name="admin_delete_leaderboard"></a>

> `admin_delete_leaderboard(id: int, on_success: Callable, on_failure: Callable)`

Delete leaderboard (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_leaderboard(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_leaderboard", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_leaderboard_record**   { #admin_delete_leaderboard_record }
<a name="admin_delete_leaderboard_record"></a>

> `admin_delete_leaderboard_record(id: int,recordId: int, on_success: Callable, on_failure: Callable)`

Delete leaderboard record (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_leaderboard_record(
	# id: int   Eg: 56
	id,
	# recordId: int   Eg: 56
	recordId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_leaderboard_record", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_leaderboard_user_record**   { #admin_delete_leaderboard_user_record }
<a name="admin_delete_leaderboard_user_record"></a>

> `admin_delete_leaderboard_user_record(id: int,userId: int, on_success: Callable, on_failure: Callable)`

Delete a user's record (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_leaderboard_user_record(
	# id: int   Eg: 56
	id,
	# userId: int   Eg: 56
	userId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_leaderboard_user_record", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_end_leaderboard**   { #admin_end_leaderboard }
<a name="admin_end_leaderboard"></a>

> `admin_end_leaderboard(id: int, on_success: Callable, on_failure: Callable)`

End leaderboard (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)


# Invoke an endpoint
api.admin_end_leaderboard(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_end_leaderboard", response)
		assert(response.data is admin_end_leaderboard_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_submit_leaderboard_score**   { #admin_submit_leaderboard_score }
<a name="admin_submit_leaderboard_score"></a>

> `admin_submit_leaderboard_score(id: int,adminSubmitLeaderboardScoreRequest = null, on_success: Callable, on_failure: Callable)`

Submit score (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)

var adminSubmitLeaderboardScoreRequest = AdminSubmitLeaderboardScoreRequest.new()
# … fill model adminSubmitLeaderboardScoreRequest with data

# Invoke an endpoint
api.admin_submit_leaderboard_score(
	# id: int   Eg: 56
	id,
	# adminSubmitLeaderboardScoreRequest: AdminSubmitLeaderboardScoreRequest
	# Score submission
	adminSubmitLeaderboardScoreRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_submit_leaderboard_score", response)
		assert(response.data is admin_submit_leaderboard_score_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_update_leaderboard**   { #admin_update_leaderboard }
<a name="admin_update_leaderboard"></a>

> `admin_update_leaderboard(id: int,adminUpdateLeaderboardRequest = null, on_success: Callable, on_failure: Callable)`

Update leaderboard (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)

var adminUpdateLeaderboardRequest = AdminUpdateLeaderboardRequest.new()
# … fill model adminUpdateLeaderboardRequest with data

# Invoke an endpoint
api.admin_update_leaderboard(
	# id: int   Eg: 56
	id,
	# adminUpdateLeaderboardRequest: AdminUpdateLeaderboardRequest
	# Leaderboard patch
	adminUpdateLeaderboardRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_update_leaderboard", response)
		assert(response.data is admin_end_leaderboard_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_update_leaderboard_record**   { #admin_update_leaderboard_record }
<a name="admin_update_leaderboard_record"></a>

> `admin_update_leaderboard_record(id: int,recordId: int,adminUpdateLeaderboardRecordRequest = null, on_success: Callable, on_failure: Callable)`

Update leaderboard record (admin)



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
var api = AdminLeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminLeaderboardsApi.new(config, client)

var adminUpdateLeaderboardRecordRequest = AdminUpdateLeaderboardRecordRequest.new()
# … fill model adminUpdateLeaderboardRecordRequest with data

# Invoke an endpoint
api.admin_update_leaderboard_record(
	# id: int   Eg: 56
	id,
	# recordId: int   Eg: 56
	recordId,
	# adminUpdateLeaderboardRecordRequest: AdminUpdateLeaderboardRecordRequest
	# Record patch
	adminUpdateLeaderboardRecordRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_update_leaderboard_record", response)
		assert(response.data is admin_submit_leaderboard_score_200_response)
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

