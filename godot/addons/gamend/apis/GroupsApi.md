<a name="__pageTop"></a>
# GroupsApi   { #GroupsApi }


All URIs are relative to *http://localhost:4000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accept_group_invite**](#accept_group_invite) | **POST** `/api/v1/groups/{id}/accept_invite` | Accept a group invitation
[**approve_join_request**](#approve_join_request) | **POST** `/api/v1/groups/{id}/join_requests/{request_id}/approve` | Approve a join request (admin only)
[**cancel_group_invite**](#cancel_group_invite) | **DELETE** `/api/v1/groups/sent_invitations/{invite_id}` | Cancel a sent group invitation
[**cancel_join_request**](#cancel_join_request) | **DELETE** `/api/v1/groups/{id}/join_requests/{request_id}` | Cancel your own pending join request
[**create_group**](#create_group) | **POST** `/api/v1/groups` | Create a group
[**demote_group_member**](#demote_group_member) | **POST** `/api/v1/groups/{id}/demote` | Demote admin to member
[**get_group**](#get_group) | **GET** `/api/v1/groups/{id}` | Get group details
[**invite_to_group**](#invite_to_group) | **POST** `/api/v1/groups/{id}/invite` | Invite a user to a hidden group (admin only)
[**join_group**](#join_group) | **POST** `/api/v1/groups/{id}/join` | Join a group
[**kick_group_member**](#kick_group_member) | **POST** `/api/v1/groups/{id}/kick` | Kick a member (admin only)
[**leave_group**](#leave_group) | **POST** `/api/v1/groups/{id}/leave` | Leave a group
[**list_group_invitations**](#list_group_invitations) | **GET** `/api/v1/groups/invitations` | List my group invitations
[**list_group_members**](#list_group_members) | **GET** `/api/v1/groups/{id}/members` | List group members
[**list_groups**](#list_groups) | **GET** `/api/v1/groups` | List groups
[**list_join_requests**](#list_join_requests) | **GET** `/api/v1/groups/{id}/join_requests` | List pending join requests (admin only)
[**list_my_groups**](#list_my_groups) | **GET** `/api/v1/groups/me` | List groups I belong to
[**list_sent_invitations**](#list_sent_invitations) | **GET** `/api/v1/groups/sent_invitations` | List group invitations I have sent
[**notify_group**](#notify_group) | **POST** `/api/v1/groups/{id}/notify` | Send a notification to all group members
[**promote_group_member**](#promote_group_member) | **POST** `/api/v1/groups/{id}/promote` | Promote member to admin
[**reject_join_request**](#reject_join_request) | **POST** `/api/v1/groups/{id}/join_requests/{request_id}/reject` | Reject a join request (admin only)
[**update_group**](#update_group) | **PATCH** `/api/v1/groups/{id}` | Update a group (admin only)

# **accept_group_invite**   { #accept_group_invite }
<a name="accept_group_invite"></a>

> `accept_group_invite(id: int, on_success: Callable, on_failure: Callable)`

Accept a group invitation

Accept an invitation to join a hidden group.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.accept_group_invite(
	# id: int   Eg: 56
	# Group ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "accept_group_invite", response)
		assert(response.data is list_group_members_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **approve_join_request**   { #approve_join_request }
<a name="approve_join_request"></a>

> `approve_join_request(id: int,requestId: int, on_success: Callable, on_failure: Callable)`

Approve a join request (admin only)

Approve a pending join request. The user becomes a member.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.approve_join_request(
	# id: int   Eg: 56
	# Group ID
	id,
	# requestId: int   Eg: 56
	# Join request ID
	requestId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "approve_join_request", response)
		assert(response.data is list_group_members_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **cancel_group_invite**   { #cancel_group_invite }
<a name="cancel_group_invite"></a>

> `cancel_group_invite(inviteId: int, on_success: Callable, on_failure: Callable)`

Cancel a sent group invitation

Cancel (delete) a group invitation that the authenticated user sent.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.cancel_group_invite(
	# inviteId: int   Eg: 56
	# Notification ID of the invitation to cancel
	inviteId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "cancel_group_invite", response)
		assert(response.data is cancel_group_invite_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **cancel_join_request**   { #cancel_join_request }
<a name="cancel_join_request"></a>

> `cancel_join_request(id: int,requestId: int, on_success: Callable, on_failure: Callable)`

Cancel your own pending join request

Cancel a join request that the current user previously sent.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.cancel_join_request(
	# id: int   Eg: 56
	# Group ID
	id,
	# requestId: int   Eg: 56
	# Join request ID
	requestId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "cancel_join_request", response)
		assert(response.data is cancel_join_request_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **create_group**   { #create_group }
<a name="create_group"></a>

> `create_group(createGroupRequest = null, on_success: Callable, on_failure: Callable)`

Create a group

Create a new group. The authenticated user becomes an admin member automatically.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var createGroupRequest = CreateGroupRequest.new()
# … fill model createGroupRequest with data

# Invoke an endpoint
api.create_group(
	# createGroupRequest: CreateGroupRequest
	# Group creation parameters
	createGroupRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "create_group", response)
		assert(response.data is list_my_groups_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **demote_group_member**   { #demote_group_member }
<a name="demote_group_member"></a>

> `demote_group_member(id: int,demoteGroupMemberRequest = null, on_success: Callable, on_failure: Callable)`

Demote admin to member

Demote an admin to regular member. Only admins can demote.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var demoteGroupMemberRequest = DemoteGroupMemberRequest.new()
# … fill model demoteGroupMemberRequest with data

# Invoke an endpoint
api.demote_group_member(
	# id: int   Eg: 56
	# Group ID
	id,
	# demoteGroupMemberRequest: DemoteGroupMemberRequest
	# Demote parameters
	demoteGroupMemberRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "demote_group_member", response)
		assert(response.data is list_group_members_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **get_group**   { #get_group }
<a name="get_group"></a>

> `get_group(id: int, on_success: Callable, on_failure: Callable)`

Get group details

Get a single group by ID including member count.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.get_group(
	# id: int   Eg: 56
	# Group ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "get_group", response)
		assert(response.data is list_my_groups_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **invite_to_group**   { #invite_to_group }
<a name="invite_to_group"></a>

> `invite_to_group(id: int,inviteToGroupRequest = null, on_success: Callable, on_failure: Callable)`

Invite a user to a hidden group (admin only)

Send an invitation notification to a user for a hidden group. The user can then accept it.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var inviteToGroupRequest = InviteToGroupRequest.new()
# … fill model inviteToGroupRequest with data

# Invoke an endpoint
api.invite_to_group(
	# id: int   Eg: 56
	# Group ID
	id,
	# inviteToGroupRequest: InviteToGroupRequest
	# Invite parameters
	inviteToGroupRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "invite_to_group", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **join_group**   { #join_group }
<a name="join_group"></a>

> `join_group(id: int, on_success: Callable, on_failure: Callable)`

Join a group

Join a group. For public groups the user is added immediately. For private groups a join request is created (an admin must approve it). Hidden groups require an invite and cannot be joined directly.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.join_group(
	# id: int   Eg: 56
	# Group ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "join_group", response)
		assert(response.data is list_group_members_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **kick_group_member**   { #kick_group_member }
<a name="kick_group_member"></a>

> `kick_group_member(id: int,kickGroupMemberRequest = null, on_success: Callable, on_failure: Callable)`

Kick a member (admin only)

Remove a member from the group. Only group admins can kick.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var kickGroupMemberRequest = KickGroupMemberRequest.new()
# … fill model kickGroupMemberRequest with data

# Invoke an endpoint
api.kick_group_member(
	# id: int   Eg: 56
	# Group ID
	id,
	# kickGroupMemberRequest: KickGroupMemberRequest
	# Kick parameters
	kickGroupMemberRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "kick_group_member", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **leave_group**   { #leave_group }
<a name="leave_group"></a>

> `leave_group(id: int, on_success: Callable, on_failure: Callable)`

Leave a group

Leave a group you are a member of.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.leave_group(
	# id: int   Eg: 56
	# Group ID
	id,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "leave_group", response)
		assert(response.data is )
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_group_invitations**   { #list_group_invitations }
<a name="list_group_invitations"></a>

> `list_group_invitations(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List my group invitations

List pending group invitations for the authenticated user, with pagination.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.list_group_invitations(
	# page: int   Eg: 56
	# Page number (default: 1)
	page,
	# pageSize: int   Eg: 56
	# Items per page (default: 25)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_group_invitations", response)
		assert(response.data is list_group_invitations_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_group_members**   { #list_group_members }
<a name="list_group_members"></a>

> `list_group_members(id: int,page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List group members

Get paginated members of a group with their roles.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.list_group_members(
	# id: int   Eg: 56
	# Group ID
	id,
	# page: int   Eg: 56
	# Page number (default: 1)
	page,
	# pageSize: int   Eg: 56
	# Items per page (default: 25)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_group_members", response)
		assert(response.data is list_group_members_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_groups**   { #list_groups }
<a name="list_groups"></a>

> `list_groups(title = "",type = "",minMembers = null,maxMembers = null,metadataKey = "",metadataValue = "",page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List groups

Return all non-hidden groups. Supports filtering by title, type, max_members, and metadata.

### Example


```gdscript

# Customize configuration
var config := ApiApiConfigClient.new()
config.host = "localhost"
config.port = 8080
#config.tls_enabled = true
#config.trusted_chain = preload("res://my_cert_chain.crt")

# Instantiate the api
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.list_groups(
	# title: String = ""   Eg: title_example
	# Search by title (prefix)
	title,
	# type: String = ""   Eg: type_example
	# Filter by group type
	type,
	# minMembers: int   Eg: 56
	# Minimum max_members to include
	minMembers,
	# maxMembers: int   Eg: 56
	# Maximum max_members to include
	maxMembers,
	# metadataKey: String = ""   Eg: metadataKey_example
	# Metadata key to filter by
	metadataKey,
	# metadataValue: String = ""   Eg: metadataValue_example
	# Metadata value to match (with metadata_key)
	metadataValue,
	# page: int   Eg: 56
	# Page number
	page,
	# pageSize: int   Eg: 56
	# Page size
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_groups", response)
		assert(response.data is list_my_groups_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_join_requests**   { #list_join_requests }
<a name="list_join_requests"></a>

> `list_join_requests(id: int,page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List pending join requests (admin only)

List pending join requests for a group. Only group admins can view.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.list_join_requests(
	# id: int   Eg: 56
	# Group ID
	id,
	# page: int   Eg: 56
	# Page number
	page,
	# pageSize: int   Eg: 56
	# Page size
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_join_requests", response)
		assert(response.data is list_join_requests_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_my_groups**   { #list_my_groups }
<a name="list_my_groups"></a>

> `list_my_groups(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List groups I belong to

List groups the authenticated user is a member of, with pagination.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.list_my_groups(
	# page: int   Eg: 56
	# Page number (default: 1)
	page,
	# pageSize: int   Eg: 56
	# Items per page (default: 25)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_my_groups", response)
		assert(response.data is list_my_groups_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **list_sent_invitations**   { #list_sent_invitations }
<a name="list_sent_invitations"></a>

> `list_sent_invitations(page = null,pageSize = null, on_success: Callable, on_failure: Callable)`

List group invitations I have sent

List group invitations sent by the authenticated user, with pagination.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.list_sent_invitations(
	# page: int   Eg: 56
	# Page number (default: 1)
	page,
	# pageSize: int   Eg: 56
	# Items per page (default: 25)
	pageSize,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "list_sent_invitations", response)
		assert(response.data is list_sent_invitations_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **notify_group**   { #notify_group }
<a name="notify_group"></a>

> `notify_group(id: int,notifyGroupRequest = null, on_success: Callable, on_failure: Callable)`

Send a notification to all group members

Broadcasts a notification to every member of the group (except the sender). Any group member can send. Sending again from the same user with the same title replaces the previous notification (upsert, prevents spam).

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var notifyGroupRequest = NotifyGroupRequest.new()
# … fill model notifyGroupRequest with data

# Invoke an endpoint
api.notify_group(
	# id: int   Eg: 56
	# Group ID
	id,
	# notifyGroupRequest: NotifyGroupRequest
	# Notification payload
	notifyGroupRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "notify_group", response)
		assert(response.data is notify_group_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **promote_group_member**   { #promote_group_member }
<a name="promote_group_member"></a>

> `promote_group_member(id: int,promoteGroupMemberRequest = null, on_success: Callable, on_failure: Callable)`

Promote member to admin

Promote a member to admin role. Only admins can promote.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var promoteGroupMemberRequest = PromoteGroupMemberRequest.new()
# … fill model promoteGroupMemberRequest with data

# Invoke an endpoint
api.promote_group_member(
	# id: int   Eg: 56
	# Group ID
	id,
	# promoteGroupMemberRequest: PromoteGroupMemberRequest
	# Promote parameters
	promoteGroupMemberRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "promote_group_member", response)
		assert(response.data is list_group_members_200_response_data_inner)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **reject_join_request**   { #reject_join_request }
<a name="reject_join_request"></a>

> `reject_join_request(id: int,requestId: int, on_success: Callable, on_failure: Callable)`

Reject a join request (admin only)

Reject a pending join request.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)


# Invoke an endpoint
api.reject_join_request(
	# id: int   Eg: 56
	# Group ID
	id,
	# requestId: int   Eg: 56
	# Join request ID
	requestId,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "reject_join_request", response)
		assert(response.data is cancel_join_request_200_response)
		pass  # do things, make stuff
		,
	# On Error
	func(error):  # error is ApiApiErrorClient
		push_error(str(error))
		,
)

```

# **update_group**   { #update_group }
<a name="update_group"></a>

> `update_group(id: int,updateGroupRequest = null, on_success: Callable, on_failure: Callable)`

Update a group (admin only)

Update group settings. Only group admins can update. Cannot reduce max_members below current member count.

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
var api = GroupsApi.new(config)
# You can also provide your own HTTPClient, to re-use it across apis.
#var api = GroupsApi.new(config, client)

var updateGroupRequest = UpdateGroupRequest.new()
# … fill model updateGroupRequest with data

# Invoke an endpoint
api.update_group(
	# id: int   Eg: 56
	# Group ID
	id,
	# updateGroupRequest: UpdateGroupRequest
	# Group update parameters
	updateGroupRequest,
	# On Success
	func(response):  # response is ApiApiResponseClient
		prints("Success!", "update_group", response)
		assert(response.data is list_my_groups_200_response_data_inner)
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

