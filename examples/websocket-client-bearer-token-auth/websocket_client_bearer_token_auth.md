# WebSocket client - Bearer token authentication

The `websocket:Client` secured with Bearer token authentication allows you to connect to a secured WebSocket server. Provide the `BearerTokenConfig` for the `auth` configuration of the client to enrich the initial HTTP request with the `Authorization: Bearer <token>` header.

::: code websocket_client_bearer_token_auth.bal :::

Run the client program by executing the command below.

::: out websocket_client_bearer_token_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
