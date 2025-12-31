<a name="__pageTop"></a>
# HooksApi   { #HooksApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**call_hook**](#call_hook) | **POST** `/api/v1/hooks/call` | Invoke a hook function
[**list_hooks**](#list_hooks) | **GET** `/api/v1/hooks` | List available hook functions

# **call_hook**   { #call_hook }
<a name="call_hook"></a>

> `call_hook(callHookRequest = null, on_success: Callable, on_failure: Callable)`

Invoke a hook function



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
var api = HooksApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = HooksApi.new(config, client)

var callHookRequest = CallHookRequest.new()
# … fill model callHookRequest with data

# Invoke an endpoint
api.call_hook(
	# callHookRequest: CallHookRequest
	# Call hook
	callHookRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "call_hook", response)
		assert(response.data is call_hook_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_hooks**   { #list_hooks }
<a name="list_hooks"></a>

> `list_hooks( on_success: Callable, on_failure: Callable)`

List available hook functions



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
var api = HooksApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = HooksApi.new(config, client)


# Invoke an endpoint
api.list_hooks(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_hooks", response)
		assert(response.data is )
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

