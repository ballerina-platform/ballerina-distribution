# gRPC client - Self signed JWT authentication

A client, which is secured with self-signed JWT can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `http:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

   ::: code grpc_client_self_signed_jwt_auth.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [unary RPC client](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Start the [JWT Auth service](/learn/by-example/grpc-service-jwt-auth/).

Execute the command below to run the client.

   ::: out grpc_client_self_signed_jwt_auth.out :::

## Related links
- [`grpc:JwtIssuerConfig` - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/JwtIssuerConfig)
- [Self signed JWT authentication - specification](/spec/grpc/#5117-client---self-signed-jwt-auth)
- [`oauth2` package - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
