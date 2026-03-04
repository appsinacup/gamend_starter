<a name="__pageTop"></a>
# NotificationsApi   { #NotificationsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_notifications**](#delete_notifications) | **DELETE** `/api/v1/notifications` | Delete notifications by IDs
[**list_notifications**](#list_notifications) | **GET** `/api/v1/notifications` | List own notifications
[**send_notification**](#send_notification) | **POST** `/api/v1/notifications` | Send a notification to a friend

# **delete_notifications**   { #delete_notifications }
<a name="delete_notifications"></a>

> `delete_notifications(deleteNotificationsRequest = null, on_success: Callable, on_failure: Callable)`

Delete notifications by IDs

Delete one or more notifications belonging to the authenticated user. Pass an array of notification IDs.

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
var api = NotificationsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = NotificationsApi.new(config, client)

var deleteNotificationsRequest = DeleteNotificationsRequest.new()
# … fill model deleteNotificationsRequest with data

# Invoke an endpoint
api.delete_notifications(
	# deleteNotificationsRequest: DeleteNotificationsRequest
	# Notification IDs to delete
	deleteNotificationsRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "delete_notifications", response)
		assert(response.data is delete_notifications_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_notifications**   { #list_notifications }
<a name="list_notifications"></a>

> `list_notifications(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List own notifications

Return all undeleted notifications for the authenticated user, ordered oldest-first. Supports pagination.

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
var api = NotificationsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = NotificationsApi.new(config, client)


# Invoke an endpoint
api.list_notifications(
	# page: int   Eg: 56
	# Page number (1-based)
	page,
	# pageSize: int   Eg: 56
	# Page size (max results per page)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_notifications", response)
		assert(response.data is list_notifications_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **send_notification**   { #send_notification }
<a name="send_notification"></a>

> `send_notification(sendNotificationRequest = null, on_success: Callable, on_failure: Callable)`

Send a notification to a friend

Send a notification to an accepted friend. The recipient will receive it in real-time (if connected) and it persists until deleted.

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
var api = NotificationsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = NotificationsApi.new(config, client)

var sendNotificationRequest = SendNotificationRequest.new()
# … fill model sendNotificationRequest with data

# Invoke an endpoint
api.send_notification(
	# sendNotificationRequest: SendNotificationRequest
	# Notification payload
	sendNotificationRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "send_notification", response)
		assert(response.data is list_notifications_200_response_data_inner)
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

