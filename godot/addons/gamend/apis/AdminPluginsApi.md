<a name="__pageTop"></a>
# AdminPluginsApi   { #AdminPluginsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admin_plugins_build**](#admin_plugins_build) | **POST** `/api/v1/admin/plugins/build` | Build plugin bundle (admin)
[**admin_plugins_buildable**](#admin_plugins_buildable) | **GET** `/api/v1/admin/plugins/buildable` | List buildable plugin sources (admin)
[**admin_plugins_reload**](#admin_plugins_reload) | **POST** `/api/v1/admin/plugins/reload` | Reload hook plugins (admin)

# **admin_plugins_build**   { #admin_plugins_build }
<a name="admin_plugins_build"></a>

> `admin_plugins_build(adminPluginsBuildRequest = null, on_success: Callable, on_failure: Callable)`

Build plugin bundle (admin)



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
var api = AdminPluginsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminPluginsApi.new(config, client)

var adminPluginsBuildRequest = AdminPluginsBuildRequest.new()
# … fill model adminPluginsBuildRequest with data

# Invoke an endpoint
api.admin_plugins_build(
	# adminPluginsBuildRequest: AdminPluginsBuildRequest
	# Build request
	adminPluginsBuildRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_plugins_build", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_plugins_buildable**   { #admin_plugins_buildable }
<a name="admin_plugins_buildable"></a>

> `admin_plugins_buildable( on_success: Callable, on_failure: Callable)`

List buildable plugin sources (admin)



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
var api = AdminPluginsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminPluginsApi.new(config, client)


# Invoke an endpoint
api.admin_plugins_buildable(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_plugins_buildable", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **admin_plugins_reload**   { #admin_plugins_reload }
<a name="admin_plugins_reload"></a>

> `admin_plugins_reload( on_success: Callable, on_failure: Callable)`

Reload hook plugins (admin)



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
var api = AdminPluginsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AdminPluginsApi.new(config, client)


# Invoke an endpoint
api.admin_plugins_reload(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "admin_plugins_reload", response)
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

