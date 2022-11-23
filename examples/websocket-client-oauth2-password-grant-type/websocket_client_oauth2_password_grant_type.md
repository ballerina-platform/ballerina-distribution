# WebSocket client - OAuth2 password grant type

A client, which is secured with OAuth2 password grant type can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `websocket:OAuth2PasswordGrantConfig` to the `auth` configuration of the client.

::: code websocket_client_oauth2_password_grant_type.bal :::

Run the client program by executing the command below.

>**Tip:** As a prerequisite to running the client, start the [OAuth2 service](/learn/by-example/websocket-service-oauth2/).

::: out websocket_client_oauth2_password_grant_type.out :::

## Related Links
- [`websocket` - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [`websocket` authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
