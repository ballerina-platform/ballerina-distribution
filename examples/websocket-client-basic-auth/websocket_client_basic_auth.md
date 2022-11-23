# WebSocket client - Basic authentication

A client, which is secured with Basic authentication can be used to connect to a secured service. The client is enriched with the `Authorization: Basic <token>` header by passing the `websocket:CredentialsConfig` for the `auth` configuration of the client.

::: code websocket_client_basic_auth.bal :::

Run the client program by executing the command below.

>**Tip:** As a prerequisite to running the client, start the [Basic authentication file user store service](/learn/by-example/websocket-service-basic-auth-file-user-store/).

::: out websocket_client_basic_auth.out :::

## Related Links
- [`websocket` - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [`websocket` authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
