# WebSocket service - Basic authentication file user store

A WebSocket service can be secured with Basic authentication and optionally by enforcing authorization. Then, it validates the Basic authentication token sent in the `Authorization` header against the provided configurations. This reads data from a file, which has a TOML format. This stores the usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). In the authorization phase, the scopes of the service are compared against the scope included in the user store for at least one match between the two sets. The `Config.toml` file is used to store the usernames, passwords, and scopes. Each user can have a password and optionally assigned scopes as an array.

::: code websocket_service_basic_auth_file_user_store.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

    ```toml
    [[ballerina.auth.users]]
    username="alice"
    password="password1"
    scopes=["scope1"]
    [[ballerina.auth.users]]
    username="bob"
    password="password2"
    scopes=["scope2", "scope3"]
    ```
Run the service by executing the command below.

::: out websocket_service_basic_auth_file_user_store.server.out :::

>**Tip:** Alternatively, you can invoke the above service via the [Basic authentication client](/learn/by-example/websocket-client-basic-auth).

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [`websocket` authentication - Specification](/spec/websocket/#52-authentication-and-authorization)