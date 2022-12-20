# WebSocket service - JWT authentication

The `websocket:Service` and resource function can be secured with JWT and additionally, scopes can be added to enforce authorization. It validates the JWT sent in the `Authorization` header against the provided configurations. Ballerina uses the concept of scopes for authorization. The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service/resource are compared against the scope included in the JWT for at least one match between the two sets.

::: code websocket_service_jwt_auth.bal :::

Run the service by executing the command below.

::: out websocket_service_jwt_auth.server.out :::

>**Tip:** You can invoke the above service via the [self-signed JWT authentication client](/learn/by-example/websocket-client-self-signed-jwt-auth).

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`jwt` module - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)