<a name="__pageTop"></a>
# KVApi   { #KVApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_kv**](#get_kv) | **GET** `/api/v1/kv/{key}` | Get a key/value entry

# **get_kv**   { #get_kv }
<a name="get_kv"></a>

> `get_kv(key: String,userId = null, on_success: Callable, on_failure: Callable)`

Get a key/value entry



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
var api = KVApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = KVApi.new(config, client)


# Invoke an endpoint
api.get_kv(
	# key: String = ""   Eg: key_example
	# Key
	key,
	# userId: int   Eg: 56
	# Optional owner user id
	userId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_kv", response)
		assert(response.data is get_kv_200_response)
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

