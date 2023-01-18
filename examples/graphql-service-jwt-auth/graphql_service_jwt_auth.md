# GraphQL service - JWT authentication

The `graphql:Service` can be secured with JWT and additionally, scopes can be added to enforce authorization. It validates the JWT sent in the `Authorization` header against the provided configurations. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service are compared against the scope included in the JWT for at least one match between the two sets.

::: code graphql_service_jwt_auth.bal :::

Run the service by executing the command below.

::: out graphql_service_jwt_auth.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - Self-signed JWT authentication](/learn/by-example/graphql-client-security-self-signed-jwt-authentication/) example.

## Related links
- [`graphql:ServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/annotations#ServiceConfig)
- [`graphql:JwtValidatorConfigWithScopes` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/JwtValidatorConfigWithScopes)
- [`jwt` module - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [GraphQL service JWT authentication - Specification](/spec/graphql/#11113-jwt-authentication)
