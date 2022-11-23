# gRPC client - OAuth2 client credentials grant type 

A client, which is secured with OAuth2 client credentials grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2ClientCredentialsGrantConfig` for the `auth` configuration of the client.

>**Info:** Setting up the client is the same as setting up the simple RPC client with additional configurations. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

   ::: code grpc_client_oauth2_client_credentials_grant_type.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start the [OAuth2 service](/learn/by-example/grpc-service-oauth2/).

   ::: out grpc_client_oauth2_client_credentials_grant_type.out :::

## Related links
- [`grpc:OAuth2ClientCredentialsGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/OAuth2ClientCredentialsGrantConfig)
- [OAuth2 authentication and authorization - specification](/spec/grpc/#5118-client---oauth2)
- [`oauth2` package - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
