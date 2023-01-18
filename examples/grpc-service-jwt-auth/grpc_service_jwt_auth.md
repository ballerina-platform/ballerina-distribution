# gRPC service - JWT authentication

The `grpc:Service` can be secured with JWT and additionally, scopes can be added to enforce authorization. It validates the JWT sent in the `Authorization` metadata against the provided configurations. Ballerina uses the concept of scopes for authorization. The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service are compared against the scope included in the JWT for at least one match between the two sets.

   ::: code grpc_service_jwt_auth.bal :::

Setting up the service is the same as setting up the simple RPC service with additional configurations. For information on implementing the service, see [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/).

Run the service by executing the command below.

   ::: out grpc_service_jwt_auth.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Self signed JWT authentication](/learn/by-example/grpc-client-self-signed-jwt-auth).

## Related links
- [`grpc:JwtValidatorConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/JwtValidatorConfig)
- [gRPC service JWT authentication - Specification](/spec/grpc/#5113-service---jwt-auth)
- [`jwt` package - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
