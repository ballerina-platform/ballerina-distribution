# gRPC client - OAuth2 client credentials grant type 

A client, which is secured with OAuth2 client credentials grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2ClientCredentialsGrantConfig` for the `auth` configuration of the client.

   ::: code grpc_client_oauth2_client_credentials_grant_type.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Run the gRPC service given in the [gRPC service - OAuth2](/learn/by-example/grpc-service-oauth2/) example.

Execute the command below to run the client.

   ::: out grpc_client_oauth2_client_credentials_grant_type.out :::

## Related links
- [`grpc:OAuth2ClientCredentialsGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/OAuth2ClientCredentialsGrantConfig)
- [OAuth2 authentication and authorization - Specification](/spec/grpc/#5118-client---oauth2)
- [`oauth2` package - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
