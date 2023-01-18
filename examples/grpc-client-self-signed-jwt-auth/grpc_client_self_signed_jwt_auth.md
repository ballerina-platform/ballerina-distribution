# gRPC client - Self signed JWT authentication

The `grpc:Client` can connect to a service that is secured with self-signed JWT by enriching the client metadata with the `Authorization: Bearer <token>` header by passing the `grpc:JwtIssuerConfig` to the auth configuration of the client. A self-signed JWT is issued before the request is sent.

   ::: code grpc_client_self_signed_jwt_auth.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run the gRPC service given in the [gRPC service - JWT authentication](/learn/by-example/grpc-service-jwt-auth/) example.

Run the client by executing the command below.

   ::: out grpc_client_self_signed_jwt_auth.out :::

## Related links
- [`grpc:JwtIssuerConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/JwtIssuerConfig)
- [gRPC client self signed JWT authentication - Specification](/spec/grpc/#5117-client---self-signed-jwt-auth)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
