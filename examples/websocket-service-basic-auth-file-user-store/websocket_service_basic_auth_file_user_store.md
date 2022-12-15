# WebSocket service - Basic authentication file user store

The `websocket:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. It validates the basic authentication token sent in the `Authorization` header in the initial HTTP request against the provided configurations in the `Config.toml` file. The file stores the usernames and passwords for the authentication and the scopes for the authorization. To engage authentication, set the default values for the `fileUserStoreConfig` field and add the `Config.toml` file next to the service file. To engage authorization, set scopes to the `scopes` field. Both configurations must be given as part of the service configuration.

A `401 Unauthorized` response is sent to the client when the authentication fails, and a `403 Forbidden` response is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on user stores.

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