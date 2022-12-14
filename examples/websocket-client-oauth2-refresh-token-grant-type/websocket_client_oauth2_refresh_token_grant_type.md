# WebSocket client - OAuth2 refresh token grant type

The `websocket:Client`, which is secured with OAuth2 refresh token grant type allows you to connect to a secured service. Provide the required configurations for this grant type in the `auth` configuration of the client to enrich the initial HTTP request with the `Authorization: Bearer <token>` header. Use this grant type when you need to exchange the user's credentials for an access token. Use this grant type when the client needs to exchange a refresh token for an access token if the access token has expired. This allows the client to have a valid access token without further interaction with the user.

::: code websocket_client_oauth2_refresh_token_grant_type.bal :::

## Prerequisites
- Run the WebSocket service given in the [OAuth2](/learn/by-example/websocket-service-oauth2/) example.

Run the client program by executing the command below.

::: out websocket_client_oauth2_refresh_token_grant_type.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
