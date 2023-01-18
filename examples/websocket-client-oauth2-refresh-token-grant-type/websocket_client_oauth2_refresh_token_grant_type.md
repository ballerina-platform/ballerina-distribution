# WebSocket client - OAuth2 refresh token grant type

The `websocket:Client` can connect to a service that is secured with the OAuth2 refresh token grant type by adding the `Authorization: Bearer <token>` header to the initial HTTP request. The required configurations for this grant type can be specified in the `auth` field of the client configuration. Use this to retrieve an access token automatically when it is expired.

::: code websocket_client_oauth2_refresh_token_grant_type.bal :::

## Prerequisites
- Run the WebSocket service given in the [OAuth2](/learn/by-example/websocket-service-oauth2/) example.

Run the client program by executing the command below.

::: out websocket_client_oauth2_refresh_token_grant_type.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
