# gRPC service - JWT authentication

A `grpc:Service` can be secured with JWT and by enforcing authorization optionally. This is achieved by validating the `Authorization` metadata against the provided configurations. A `grpc:Service` can configure the scopes it needs for authorization in the `auth` field of the `@grpc:ServiceConfig` annotation. The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service are compared against the scope included in the JWT for at least one match between the two sets.

   ::: code grpc_service_jwt_auth.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Run the service by executing the command below.

   ::: out grpc_service_jwt_auth.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Self signed JWT authentication](/learn/by-example/grpc-client-self-signed-jwt-auth).

## Related links
- [`grpc:JwtValidatorConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/JwtValidatorConfig)
- [gRPC service JWT authentication - Specification](/spec/grpc/#5113-service---jwt-auth)
- [`jwt` package - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
