<a name="__pageTop"></a>
# ChatApi   { #ChatApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**chat_unread_count**](#chat_unread_count) | **GET** `/api/v1/chat/unread` | Get unread message count
[**delete_chat_message**](#delete_chat_message) | **DELETE** `/api/v1/chat/messages/{id}` | Delete your own chat message
[**get_chat_message**](#get_chat_message) | **GET** `/api/v1/chat/messages/{id}` | Get a single chat message
[**list_chat_messages**](#list_chat_messages) | **GET** `/api/v1/chat/messages` | List chat messages
[**mark_chat_read**](#mark_chat_read) | **POST** `/api/v1/chat/read` | Mark chat as read
[**send_chat_message**](#send_chat_message) | **POST** `/api/v1/chat/messages` | Send a chat message
[**update_chat_message**](#update_chat_message) | **PATCH** `/api/v1/chat/messages/{id}` | Update your own chat message

# **chat_unread_count**   { #chat_unread_count }
<a name="chat_unread_count"></a>

> `chat_unread_count(chatType: String,chatRefId: int, on_success: Callable, on_failure: Callable)`

Get unread message count

Get the number of unread messages for the current user in a chat conversation.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)


# Invoke an endpoint
api.chat_unread_count(
	# chatType: String = ""   Eg: chatType_example
	chatType,
	# chatRefId: int   Eg: 56
	chatRefId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "chat_unread_count", response)
		assert(response.data is chat_unread_count_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **delete_chat_message**   { #delete_chat_message }
<a name="delete_chat_message"></a>

> `delete_chat_message(id: int, on_success: Callable, on_failure: Callable)`

Delete your own chat message

Permanently delete a message you sent. Only the sender can delete their own message.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)


# Invoke an endpoint
api.delete_chat_message(
	# id: int   Eg: 56
	# Message ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "delete_chat_message", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **get_chat_message**   { #get_chat_message }
<a name="get_chat_message"></a>

> `get_chat_message(id: int, on_success: Callable, on_failure: Callable)`

Get a single chat message

Retrieve a single chat message by ID. Useful for refreshing a message after an update notification.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)


# Invoke an endpoint
api.get_chat_message(
	# id: int   Eg: 56
	# Message ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_chat_message", response)
		assert(response.data is get_chat_message_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_chat_messages**   { #list_chat_messages }
<a name="list_chat_messages"></a>

> `list_chat_messages(chatType: String,chatRefId: int,page = 1,pageSize = 25, on_success: Callable, on_failure: Callable)`

List chat messages

List messages for a lobby, group, party, or friend conversation. Paginated, newest first.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)


# Invoke an endpoint
api.list_chat_messages(
	# chatType: String = ""   Eg: chatType_example
	# Type of chat
	chatType,
	# chatRefId: int   Eg: 56
	# Reference ID (lobby_id, group_id, party_id, or friend user_id)
	chatRefId,
	# page: int = 1   Eg: 56
	# Page number
	page,
	# pageSize: int = 25   Eg: 56
	# Items per page (max 100)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_chat_messages", response)
		assert(response.data is list_chat_messages_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **mark_chat_read**   { #mark_chat_read }
<a name="mark_chat_read"></a>

> `mark_chat_read(markChatReadRequest = null, on_success: Callable, on_failure: Callable)`

Mark chat as read

Update the read cursor for the current user in a chat conversation.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)

var markChatReadRequest = MarkChatReadRequest.new()
# … fill model markChatReadRequest with data

# Invoke an endpoint
api.mark_chat_read(
	# markChatReadRequest: MarkChatReadRequest
	# Read cursor
	markChatReadRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "mark_chat_read", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **send_chat_message**   { #send_chat_message }
<a name="send_chat_message"></a>

> `send_chat_message(sendChatMessageRequest = null, on_success: Callable, on_failure: Callable)`

Send a chat message

Send a message to a lobby, group, party, or friend conversation. Requires authentication and membership/friendship.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)

var sendChatMessageRequest = SendChatMessageRequest.new()
# … fill model sendChatMessageRequest with data

# Invoke an endpoint
api.send_chat_message(
	# sendChatMessageRequest: SendChatMessageRequest
	# Chat message
	sendChatMessageRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "send_chat_message", response)
		assert(response.data is get_chat_message_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **update_chat_message**   { #update_chat_message }
<a name="update_chat_message"></a>

> `update_chat_message(id: int,updateChatMessageRequest = null, on_success: Callable, on_failure: Callable)`

Update your own chat message

Edit the content or metadata of a message you sent. Only the sender can update their own message.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = ChatApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = ChatApi.new(config, client)

var updateChatMessageRequest = UpdateChatMessageRequest.new()
# … fill model updateChatMessageRequest with data

# Invoke an endpoint
api.update_chat_message(
	# id: int   Eg: 56
	# Message ID
	id,
	# updateChatMessageRequest: UpdateChatMessageRequest
	# Message update
	updateChatMessageRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "update_chat_message", response)
		assert(response.data is get_chat_message_200_response)
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

