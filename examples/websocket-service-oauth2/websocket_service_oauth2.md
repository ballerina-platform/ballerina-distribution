# WebSocket service - OAuth2

A WebSocket service can be secured with OAuth2 and by enforcing authorization optionally. Then, it validates the OAuth2 token sent in the `Authorization` header against the provided configurations. This calls the configured introspection endpoint to validate.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service are compared against the scope included in the introspection response for at least one match between the two sets.

::: code websocket_service_oauth2.bal :::

Run the service by executing the cURL command below.

::: out websocket_service_oauth2.server.out :::

>**Tip:** Alternatively, you can invoke the above service via the [OAuth2 JWT Bearer grant type client](/learn/by-example/websocket-client-oauth2-jwt-bearer-grant-type).

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`oauth2` package - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [`websocket` authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
