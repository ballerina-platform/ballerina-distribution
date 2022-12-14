# WebSocket client - OAuth2 JWT bearer grant type

The `websocket:Client` secured with OAuth2 JWT bearer grant type allows you to connect to a secured WebSocket server. Provide the required configurations for this grant type in the `auth` configuration of the client to enrich the initial HTTP request with the `Authorization: Bearer <token>` header. Use this grant type when the client wants to receive access tokens without transmitting sensitive information such as the client secret.

::: code websocket_client_oauth2_jwt_bearer_grant_type.bal :::

## Prerequisites
- Run the WebSocket service given in the [OAuth2](/learn/by-example/websocket-service-oauth2/) example.

Run the client program by executing the command below.

::: out websocket_client_oauth2_jwt_bearer_grant_type.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
