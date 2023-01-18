# WebSocket client - Self signed JWT authentication

The `websocket:Client` can connect to a service that is secured with self-signed JWT by adding the `Authorization: Bearer <token>` header by passing the `websocket:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

::: code websocket_client_self_signed_jwt_auth.bal :::

## Prerequisites
- Run the WebSocket service given in the [JWT authentication](/learn/by-example/websocket-service-jwt-auth/) example.

Run the client program by executing the command below.

::: out websocket_client_self_signed_jwt_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
