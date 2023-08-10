# WebSocket service - OAuth2

The `websocket:Service` and resource function can be secured with OAuth2 and additionally, scopes can be added to enforce fine-grained authorization. It validates the OAuth2 token sent in the `Authorization` header against the provided configurations. This calls the configured introspection endpoint to validate. Ballerina uses the concept of scopes for authorization.  The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service/resource are compared against the scope included in the introspection response for at least one match between the two sets.

::: code websocket_service_oauth2.bal :::

Run the service by executing the command below.

::: out websocket_service_oauth2.server.out :::

>**Tip:** You can invoke the above service via the [OAuth2 JWT Bearer grant type client](/learn/by-example/websocket-client-oauth2-jwt-bearer-grant-type).

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
