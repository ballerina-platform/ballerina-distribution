# WebSocket client - Bearer token authentication

The `websocket:Client` can be secured with bearer token authentication by enriching the initial HTTP request from the client with the `Authorization: Bearer <token>` header. The bearer token can be specified in the `auth` field of the client configuration. Use this to communicate with the service, which is secured with bearer token authentication.

::: code websocket_client_bearer_token_auth.bal :::

Run the client program by executing the command below.

::: out websocket_client_bearer_token_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
