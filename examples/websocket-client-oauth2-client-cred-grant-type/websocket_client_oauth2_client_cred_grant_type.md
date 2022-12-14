# WebSocket client - OAuth2 client credentials grant type

The `websocket:Client` secured with OAuth2 client credentials grant type allows you to connect to a secured WebSocket server. Provide the required configurations for this grant type in the `auth` configuration of the client to enrich the initial HTTP request with the `Authorization: Bearer <token>` header. Use this grant type when the client needs to access resources or services on behalf of itself rather than the user.

::: code websocket_client_oauth2_client_cred_grant_type.bal :::

## Prerequisites
- Run the WebSocket service given in the [OAuth2](/learn/by-example/websocket-service-oauth2/) example.

Run the client program by executing the command below.

::: out websocket_client_oauth2_client_cred_grant_type.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
