# WebSocket service - Basic authentication file user store

The `websocket:Service` can be secured with basic authentication and optionally by enforcing authorization. This can be achieved by validating the basic authentication token sent in the `Authorization` header in the initial HTTP upgrade request against the provided configurations in the `Config.toml` file. This file stores the usernames and passwords for the authentication and the scopes for the authorization. A `websocket:Service` can configure the scopes it needs for authorization in the `auth` field of the `@websocket:ServiceConfig` annotation. A `401 Unauthorized` response is sent to the client when the authentication fails, and a `403 Forbidden` response is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on user stores. 

::: code websocket_service_basic_auth_file_user_store.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

::: code Config.toml :::

Run the service by executing the command below.

::: out websocket_service_basic_auth_file_user_store.server.out :::

>**Tip:** You can invoke the above service via the [Basic authentication client](/learn/by-example/websocket-client-basic-auth).

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)