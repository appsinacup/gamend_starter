<a name="__pageTop"></a>
# AuthenticationApi   { #AuthenticationApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**device_login**](#device_login) | **POST** `/api/v1/login/device` | Device login
[**link_device**](#link_device) | **POST** `/api/v1/me/device` | Link device ID
[**login**](#login) | **POST** `/api/v1/login` | Login
[**logout**](#logout) | **DELETE** `/api/v1/logout` | Logout
[**oauth_api_callback**](#oauth_api_callback) | **POST** `/api/v1/auth/{provider}/callback` | API callback / code exchange
[**oauth_callback_api_apple_ios**](#oauth_callback_api_apple_ios) | **POST** `/api/v1/auth/apple/ios/callback` | Apple callback (native iOS)
[**oauth_google_id_token**](#oauth_google_id_token) | **POST** `/api/v1/auth/google/id_token` | Google ID token login (native/mobile)
[**oauth_request**](#oauth_request) | **GET** `/api/v1/auth/{provider}` | Initiate API OAuth
[**oauth_session_status**](#oauth_session_status) | **GET** `/api/v1/auth/session/{session_id}` | Get OAuth session status
[**refresh_token**](#refresh_token) | **POST** `/api/v1/refresh` | Refresh access token
[**unlink_device**](#unlink_device) | **DELETE** `/api/v1/me/device` | Unlink device ID
[**unlink_provider**](#unlink_provider) | **DELETE** `/api/v1/me/providers/{provider}` | Unlink OAuth provider

# **device_login**   { #device_login }
<a name="device_login"></a>

> `device_login(deviceLoginRequest = null, on_success: Callable, on_failure: Callable)`

Device login

Authenticate or create a device-backed user using a device_id (no password).

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var deviceLoginRequest = DeviceLoginRequest.new()
# … fill model deviceLoginRequest with data

# Invoke an endpoint
api.device_login(
	# deviceLoginRequest: DeviceLoginRequest
	# Device login
	deviceLoginRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "device_login", response)
		assert(response.data is oauth_api_callback_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **link_device**   { #link_device }
<a name="link_device"></a>

> `link_device(linkDeviceRequest = null, on_success: Callable, on_failure: Callable)`

Link device ID

Links a device_id to the current authenticated user's account.

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
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var linkDeviceRequest = LinkDeviceRequest.new()
# … fill model linkDeviceRequest with data

# Invoke an endpoint
api.link_device(
	# linkDeviceRequest: LinkDeviceRequest
	# Device ID
	linkDeviceRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "link_device", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **login**   { #login }
<a name="login"></a>

> `login(loginRequest = null, on_success: Callable, on_failure: Callable)`

Login

Authenticate user with email and password

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var loginRequest = LoginRequest.new()
# … fill model loginRequest with data

# Invoke an endpoint
api.login(
	# loginRequest: LoginRequest
	# Login credentials
	loginRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "login", response)
		assert(response.data is login_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **logout**   { #logout }
<a name="logout"></a>

> `logout( on_success: Callable, on_failure: Callable)`

Logout

Invalidate user session token

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)


# Invoke an endpoint
api.logout(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "logout", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **oauth_api_callback**   { #oauth_api_callback }
<a name="oauth_api_callback"></a>

> `oauth_api_callback(provider: String,oauthApiCallbackRequest = null, on_success: Callable, on_failure: Callable)`

API callback / code exchange

Accepts an OAuth authorization code via the API and returns access/refresh tokens on success. If a valid JWT is provided in the Authorization header, the provider will be **linked** to the authenticated user instead of logging in. For the Steam provider, the `code` field should contain a server-verifiable Steam credential (for example a Steam auth ticket or Steam identifier) and will be validated via the Steam Web API.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var oauthApiCallbackRequest = OauthApiCallbackRequest.new()
# … fill model oauthApiCallbackRequest with data

# Invoke an endpoint
api.oauth_api_callback(
	# provider: String = ""   Eg: provider_example
	provider,
	# oauthApiCallbackRequest: OauthApiCallbackRequest
	# Code exchange or steam payload
	oauthApiCallbackRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "oauth_api_callback", response)
		assert(response.data is oauth_api_callback_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **oauth_callback_api_apple_ios**   { #oauth_callback_api_apple_ios }
<a name="oauth_callback_api_apple_ios"></a>

> `oauth_callback_api_apple_ios(oauthCallbackApiAppleIosRequest = null, on_success: Callable, on_failure: Callable)`

Apple callback (native iOS)

Exchanges a native iOS Sign in with Apple authorization code using APPLE_IOS_CLIENT_ID.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var oauthCallbackApiAppleIosRequest = OauthCallbackApiAppleIosRequest.new()
# … fill model oauthCallbackApiAppleIosRequest with data

# Invoke an endpoint
api.oauth_callback_api_apple_ios(
	# oauthCallbackApiAppleIosRequest: OauthCallbackApiAppleIosRequest
	# Apple callback params
	oauthCallbackApiAppleIosRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "oauth_callback_api_apple_ios", response)
		assert(response.data is oauth_api_callback_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **oauth_google_id_token**   { #oauth_google_id_token }
<a name="oauth_google_id_token"></a>

> `oauth_google_id_token(oauthGoogleIdTokenRequest = null, on_success: Callable, on_failure: Callable)`

Google ID token login (native/mobile)

Verify a Google OpenID Connect id_token (eg. from Android Credential Manager) and return JWT tokens.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var oauthGoogleIdTokenRequest = OauthGoogleIdTokenRequest.new()
# … fill model oauthGoogleIdTokenRequest with data

# Invoke an endpoint
api.oauth_google_id_token(
	# oauthGoogleIdTokenRequest: OauthGoogleIdTokenRequest
	# Google ID token
	oauthGoogleIdTokenRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "oauth_google_id_token", response)
		assert(response.data is oauth_api_callback_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **oauth_request**   { #oauth_request }
<a name="oauth_request"></a>

> `oauth_request(provider: String, on_success: Callable, on_failure: Callable)`

Initiate API OAuth

Returns OAuth authorization URL for API clients

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)


# Invoke an endpoint
api.oauth_request(
	# provider: String = ""   Eg: discord
	# OAuth provider
	provider,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "oauth_request", response)
		assert(response.data is oauth_request_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **oauth_session_status**   { #oauth_session_status }
<a name="oauth_session_status"></a>

> `oauth_session_status(sessionId: String, on_success: Callable, on_failure: Callable)`

Get OAuth session status

Check the status of an OAuth session for API clients

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)


# Invoke an endpoint
api.oauth_session_status(
	# sessionId: String = ""   Eg: sessionId_example
	# Session ID from OAuth request
	sessionId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "oauth_session_status", response)
		assert(response.data is OAuthSessionStatus)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **refresh_token**   { #refresh_token }
<a name="refresh_token"></a>

> `refresh_token(refreshTokenRequest = null, on_success: Callable, on_failure: Callable)`

Refresh access token

Exchange a valid refresh token for a new access token

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)

var refreshTokenRequest = RefreshTokenRequest.new()
# … fill model refreshTokenRequest with data

# Invoke an endpoint
api.refresh_token(
	# refreshTokenRequest: RefreshTokenRequest
	# Refresh token
	refreshTokenRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "refresh_token", response)
		assert(response.data is refresh_token_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **unlink_device**   { #unlink_device }
<a name="unlink_device"></a>

> `unlink_device( on_success: Callable, on_failure: Callable)`

Unlink device ID

Unlinks the device_id from the current authenticated user. Requires at least one OAuth provider or password to remain.

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
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)


# Invoke an endpoint
api.unlink_device(
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "unlink_device", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **unlink_provider**   { #unlink_provider }
<a name="unlink_provider"></a>

> `unlink_provider(provider: String, on_success: Callable, on_failure: Callable)`

Unlink OAuth provider

Unlinks a provider from the current authenticated user.

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
var api = AuthenticationApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = AuthenticationApi.new(config, client)


# Invoke an endpoint
api.unlink_provider(
	# provider: String = ""   Eg: provider_example
	provider,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "unlink_provider", response)
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

