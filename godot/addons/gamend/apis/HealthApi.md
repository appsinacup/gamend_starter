<a name="__pageTop"></a>
# HealthApi   { #HealthApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**index**](#index) | **GET** `/api/v1/health` | Health check

# **index**   { #index }
<a name="index"></a>

> `index( on_success: Callable, on_failure: Callable)`

Health check

Returns the health status of the API

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = HealthApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = HealthApi.new(config, client)


# Invoke an endpoint
api.index(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "index", response)
		assert(response.data is HealthResponse)
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

