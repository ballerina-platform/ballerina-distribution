# gRPC service - OAuth2

A gRPC service/resource can be secured with OAuth2 and by enforcing authorization optionally. Then, it validates the OAuth2 token sent in the `Authorization` metadata against the provided configurations. This calls the configured introspection endpoint to validate.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`.

In the authorization phase, the scopes of the service/resource are compared against the scope included in the introspection response for at least one match between the two sets.

   ::: code grpc_service_oauth2.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_service_oauth2.server.out :::

>**Tip:** You can invoke the above service via the clients below.
 - [gRPC client - OAuth2 client credentials grant type](/learn/by-example/grpc-client-oauth2-client-credentials-grant-type)
 - [gRPC client - OAuth2 password grant type](/learn/by-example/grpc-client-oauth2-password-grant-type)
 - [gRPC client - OAuth2 refresh token grant type](/learn/by-example/grpc-client-oauth2-refresh-token-grant-type)
 - [gRPC client - OAuth2 JWT bearer grant type](/learn/by-example/grpc-client-oauth2-jwt-bearer-grant-type)

## Related links
- [`grpc:OAuth2IntrospectionConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/OAuth2IntrospectionConfig)
- [gRPC service OAuth2 - Specification](/spec/grpc/#5114-service---oauth2)
- [`oauth2` package - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
