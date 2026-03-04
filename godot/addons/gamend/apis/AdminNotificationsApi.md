<a name="__pageTop"></a>
# AdminNotificationsApi   { #AdminNotificationsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_create_notification**](#admin_create_notification) | **POST** `/api/v1/admin/notifications` | Create a notification (admin)
[**admin_delete_notification**](#admin_delete_notification) | **DELETE** `/api/v1/admin/notifications/{id}` | Delete a notification (admin)
[**admin_list_notifications**](#admin_list_notifications) | **GET** `/api/v1/admin/notifications` | List all notifications (admin)

# **admin_create_notification**   { #admin_create_notification }
<a name="admin_create_notification"></a>

> `admin_create_notification(adminCreateNotificationRequest = null, on_success: Callable, on_failure: Callable)`

Create a notification (admin)

Create a notification from any sender to any recipient. No friendship check is performed.

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
var api = AdminNotificationsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminNotificationsApi.new(config, client)

var adminCreateNotificationRequest = AdminCreateNotificationRequest.new()
# … fill model adminCreateNotificationRequest with data

# Invoke an endpoint
api.admin_create_notification(
	# adminCreateNotificationRequest: AdminCreateNotificationRequest
	# Notification payload
	adminCreateNotificationRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_create_notification", response)
		assert(response.data is admin_list_notifications_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_notification**   { #admin_delete_notification }
<a name="admin_delete_notification"></a>

> `admin_delete_notification(id: int, on_success: Callable, on_failure: Callable)`

Delete a notification (admin)

Delete a notification by ID (no ownership check).

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
var api = AdminNotificationsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminNotificationsApi.new(config, client)


# Invoke an endpoint
api.admin_delete_notification(
	# id: int   Eg: 56
	# Notification ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_notification", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_list_notifications**   { #admin_list_notifications }
<a name="admin_list_notifications"></a>

> `admin_list_notifications(userId = null,senderId = null,title = "",page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List all notifications (admin)

Return all notifications across all users. Supports filtering by recipient user_id, sender_id, and title.

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
var api = AdminNotificationsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminNotificationsApi.new(config, client)


# Invoke an endpoint
api.admin_list_notifications(
	# userId: int   Eg: 56
	# Filter by recipient user ID
	userId,
	# senderId: int   Eg: 56
	# Filter by sender user ID
	senderId,
	# title: String = ""   Eg: title_example
	# Filter by title (partial match)
	title,
	# page: int   Eg: 56
	# Page number (1-based)
	page,
	# pageSize: int   Eg: 56
	# Page size
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_list_notifications", response)
		assert(response.data is admin_list_notifications_200_response)
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

