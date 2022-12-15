# WebSocket client - OAuth2 client credentials grant type

A client, which is secured with OAuth2 client credentials grant typecan be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `websocket:OAuth2ClientCredentialsGrantConfig` for the `auth` configuration of the client.

::: code websocket_client_oauth2_client_cred_grant_type.bal :::

## Prerequisites
- Run the WebSocket service given in the [OAuth2](/learn/by-example/websocket-service-oauth2/) example.

Run the client program by executing the command below.

::: out websocket_client_oauth2_client_cred_grant_type.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
