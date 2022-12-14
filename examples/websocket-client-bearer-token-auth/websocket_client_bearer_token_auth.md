# WebSocket client - Bearer token authentication

A client, which is secured with Bearer token authentication can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `websocket:BearerTokenConfig` for the `auth` configuration of the client.

::: code websocket_client_bearer_token_auth.bal :::

Run the client program by executing the command below.

::: out websocket_client_bearer_token_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
