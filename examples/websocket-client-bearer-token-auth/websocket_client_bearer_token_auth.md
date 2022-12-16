# WebSocket client - Bearer token authentication

The `websocket:Client` can connect to a service that is secured with bearer token authentication by adding the `Authorization: Bearer <token>` header to the initial HTTP request. The bearer token can be specified in the `auth` field of the client configuration.

::: code websocket_client_bearer_token_auth.bal :::

Run the client program by executing the command below.

::: out websocket_client_bearer_token_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
