# gRPC client - OAuth2 JWT bearer grant type 

A client, which is secured with an OAuth2 JWT bearer grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2JwtBearerGrantConfig` to the `auth` configuration of the client.

   ::: code grpc_client_oauth2_jwt_bearer_grant_type.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Run the gRPC service given in the [gRPC service - OAuth2](/learn/by-example/grpc-service-oauth2/) example.

Run the client by executing the command below.

   ::: out grpc_client_oauth2_jwt_bearer_grant_type.out :::

## Related links
- [`grpc:OAuth2JwtBearerGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/OAuth2JwtBearerGrantConfig)
- [gRPC client OAuth2 authentication and authorization - Specification](/spec/grpc/#5118-client---oauth2)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
