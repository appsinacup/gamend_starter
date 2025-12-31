<a name="__pageTop"></a>
# LeaderboardsApi   { #LeaderboardsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_leaderboard**](#get_leaderboard) | **GET** `/api/v1/leaderboards/{id}` | Get a leaderboard by ID
[**get_my_record**](#get_my_record) | **GET** `/api/v1/leaderboards/{id}/records/me` | Get current user&#x27;s record
[**list_leaderboard_records**](#list_leaderboard_records) | **GET** `/api/v1/leaderboards/{id}/records` | List leaderboard records
[**list_leaderboards**](#list_leaderboards) | **GET** `/api/v1/leaderboards` | List leaderboards
[**list_records_around_user**](#list_records_around_user) | **GET** `/api/v1/leaderboards/{id}/records/around/{user_id}` | List records around a user

# **get_leaderboard**   { #get_leaderboard }
<a name="get_leaderboard"></a>

> `get_leaderboard(id: int, on_success: Callable, on_failure: Callable)`

Get a leaderboard by ID

Return details for a specific leaderboard by its integer ID.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = LeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LeaderboardsApi.new(config, client)


# Invoke an endpoint
api.get_leaderboard(
	# id: int   Eg: 56
	# Leaderboard ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_leaderboard", response)
		assert(response.data is list_leaderboards_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **get_my_record**   { #get_my_record }
<a name="get_my_record"></a>

> `get_my_record(id: int, on_success: Callable, on_failure: Callable)`

Get current user's record

Return the authenticated user's record and rank on this leaderboard.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = LeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LeaderboardsApi.new(config, client)


# Invoke an endpoint
api.get_my_record(
	# id: int   Eg: 56
	# Leaderboard ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_my_record", response)
		assert(response.data is list_leaderboard_records_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_leaderboard_records**   { #list_leaderboard_records }
<a name="list_leaderboard_records"></a>

> `list_leaderboard_records(id: int,page = 1,pageSize = 25, on_success: Callable, on_failure: Callable)`

List leaderboard records

Return ranked records for a leaderboard by its integer ID.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = LeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LeaderboardsApi.new(config, client)


# Invoke an endpoint
api.list_leaderboard_records(
	# id: int   Eg: 56
	# Leaderboard ID
	id,
	# page: int = 1   Eg: 56
	# Page number
	page,
	# pageSize: int = 25   Eg: 56
	# Page size (max 100)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_leaderboard_records", response)
		assert(response.data is list_leaderboard_records_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_leaderboards**   { #list_leaderboards }
<a name="list_leaderboards"></a>

> `list_leaderboards(slug = "",active = "",orderBy = "ends_at",startsAfter = null,startsBefore = null,endsAfter = null,endsBefore = null,page = 1,pageSize = 25, on_success: Callable, on_failure: Callable)`

List leaderboards

Return all leaderboards with optional filters. Results are ordered by end date (active/permanent first, then most recently ended).  **Common use cases:** - Get all leaderboards: `GET /api/v1/leaderboards` - Get all seasons of a leaderboard: `GET /api/v1/leaderboards?slug=weekly_kills` - Get active leaderboard by slug: `GET /api/v1/leaderboards?slug=weekly_kills&active=true` - Get only active leaderboards: `GET /api/v1/leaderboards?active=true` 

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = LeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LeaderboardsApi.new(config, client)


# Invoke an endpoint
api.list_leaderboards(
	# slug: String = ""   Eg: slug_example
	# Filter by slug (returns all seasons of that leaderboard, ordered by end date)
	slug,
	# active: String = ""   Eg: active_example
	# Filter by active status - 'true' or 'false' (omit for all)
	active,
	# orderBy: String = "ends_at"   Eg: orderBy_example
	# Order results by field. 'ends_at' (default) puts active first, then by end date. 'inserted_at' orders by creation date.
	orderBy,
	# startsAfter: String   Eg: 2013-10-20T19:20:30+01:00
	# Only leaderboards that started after this time (ISO 8601)
	startsAfter,
	# startsBefore: String   Eg: 2013-10-20T19:20:30+01:00
	# Only leaderboards that started before this time (ISO 8601)
	startsBefore,
	# endsAfter: String   Eg: 2013-10-20T19:20:30+01:00
	# Only leaderboards ending after this time (ISO 8601)
	endsAfter,
	# endsBefore: String   Eg: 2013-10-20T19:20:30+01:00
	# Only leaderboards ending before this time (ISO 8601)
	endsBefore,
	# page: int = 1   Eg: 56
	# Page number
	page,
	# pageSize: int = 25   Eg: 56
	# Page size (max 100)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_leaderboards", response)
		assert(response.data is list_leaderboards_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_records_around_user**   { #list_records_around_user }
<a name="list_records_around_user"></a>

> `list_records_around_user(id: int,userId: int,limit = 11, on_success: Callable, on_failure: Callable)`

List records around a user

Return records centered around a specific user's rank.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = LeaderboardsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = LeaderboardsApi.new(config, client)


# Invoke an endpoint
api.list_records_around_user(
	# id: int   Eg: 56
	# Leaderboard ID
	id,
	# userId: int   Eg: 56
	# User ID to center around
	userId,
	# limit: int = 11   Eg: 56
	# Total number of records to return
	limit,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_records_around_user", response)
		assert(response.data is list_records_around_user_200_response)
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

