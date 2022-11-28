# gRPC service - JWT authentication

A gRPC service/resource can be secured with JWT and by enforcing authorization optionally. Then, it validates the JWT sent in the `Authorization` metadata against the provided configurations.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`.

In the authorization phase, the scopes of the service/resource are compared against the scope included in the JWT for at least one match between the two sets.

   ::: code grpc_service_jwt_auth.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_service_jwt_auth.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Self signed JWT authentication](/learn/by-example/grpc-client-self-signed-jwt-auth).

## Related links
- [`grpc:JwtValidatorConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/JwtValidatorConfig)
- [JWT authentication - Specification](/spec/grpc/#5113-service---jwt-auth)
- [`jwt` package - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
