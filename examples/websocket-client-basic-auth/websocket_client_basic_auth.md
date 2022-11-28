# WebSocket client - Basic authentication

A client, which is secured with Basic authentication can be used to connect to a secured service. The client is enriched with the `Authorization: Basic <token>` header by passing the `websocket:CredentialsConfig` for the `auth` configuration of the client.

::: code websocket_client_basic_auth.bal :::

## Prerequisites
- Run the WebSocket service given in the [Basic authentication file user store](/learn/by-example/websocket-service-basic-auth-file-user-store/) example.

Run the client program by executing the command below.

::: out websocket_client_basic_auth.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [`websocket` authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
