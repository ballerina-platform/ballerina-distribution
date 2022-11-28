# HTTP service - JWT authentication

An HTTP service/resource can be secured with JWT and by enforcing authorization optionally. Then, it validates the JWT sent in the `Authorization` header against the provided configurations. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service/resource are compared against the scope included in the JWT for at least one match between the two sets.

::: code http_service_jwt_authentication.bal :::

Run the service by executing the command below.

::: out http_service_jwt_authentication.server.out :::

>**Info:** You can invoke the above service via the [self-signed JWT authentication client](/learn/by-example/http-client-self-signed-jwt-authentication).

## Related links
- [`http:JwtValidatorConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/JwtValidatorConfig)
- [`jwt` package API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [`Listener JWT authentication` - specification](https://ballerina.io/spec/http/#9113-listener---jwt-auth)
