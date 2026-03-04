<a name="__pageTop"></a>
# AdminChatApi   { #AdminChatApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_delete_chat_conversation**](#admin_delete_chat_conversation) | **DELETE** `/api/v1/admin/chat/conversation` | Delete all messages in a conversation (admin)
[**admin_delete_chat_message**](#admin_delete_chat_message) | **DELETE** `/api/v1/admin/chat/{id}` | Delete a chat message (admin)
[**admin_list_chat_messages**](#admin_list_chat_messages) | **GET** `/api/v1/admin/chat` | List all chat messages (admin)

# **admin_delete_chat_conversation**   { #admin_delete_chat_conversation }
<a name="admin_delete_chat_conversation"></a>

> `admin_delete_chat_conversation(chatType: String,chatRefId: int, on_success: Callable, on_failure: Callable)`

Delete all messages in a conversation (admin)

Delete all messages for a given chat_type and chat_ref_id.

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
var api = AdminChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminChatApi.new(config, client)


# Invoke an endpoint
api.admin_delete_chat_conversation(
	# chatType: String = ""   Eg: chatType_example
	chatType,
	# chatRefId: int   Eg: 56
	chatRefId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_chat_conversation", response)
		assert(response.data is admin_delete_chat_conversation_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_delete_chat_message**   { #admin_delete_chat_message }
<a name="admin_delete_chat_message"></a>

> `admin_delete_chat_message(id: int, on_success: Callable, on_failure: Callable)`

Delete a chat message (admin)

Admin-level message deletion by ID.

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
var api = AdminChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminChatApi.new(config, client)


# Invoke an endpoint
api.admin_delete_chat_message(
	# id: int   Eg: 56
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_delete_chat_message", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_list_chat_messages**   { #admin_list_chat_messages }
<a name="admin_list_chat_messages"></a>

> `admin_list_chat_messages(senderId = null,chatType = "",chatRefId = null,content = "",sortBy = "",page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List all chat messages (admin)

List all chat messages with optional filters. Returns paginated results sorted by newest first.

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
var api = AdminChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminChatApi.new(config, client)


# Invoke an endpoint
api.admin_list_chat_messages(
	# senderId: int   Eg: 56
	senderId,
	# chatType: String = ""   Eg: chatType_example
	chatType,
	# chatRefId: int   Eg: 56
	chatRefId,
	# content: String = ""   Eg: content_example
	content,
	# sortBy: String = ""   Eg: sortBy_example
	sortBy,
	# page: int   Eg: 56
	page,
	# pageSize: int   Eg: 56
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_list_chat_messages", response)
		assert(response.data is admin_list_chat_messages_200_response)
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

