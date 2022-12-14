# WebSocket client - Basic authentication

The `websocket:Client` secured with Basic authentication allows you to connect to a WebSocket server secured with Basic authentication. Provide the `CredentialsConfig` for the `auth` configuration of the client to enrich the initial HTTP request with the `Authorization: Basic <token>` header.

::: code websocket_client_basic_auth.bal :::

## Prerequisites
- Run the WebSocket service given in the [Basic authentication file user store](/learn/by-example/websocket-service-basic-auth-file-user-store/) example.

Run the client program by executing the command below.

::: out websocket_client_basic_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
