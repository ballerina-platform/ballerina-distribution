# Client - OAuth2 Refresh Token grant type

A client, which is secured with an OAuth2 refresh token grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2RefreshTokenGrantConfig` to the `auth` configuration of the client.

>**Info:** For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/).

>**Info:** Setting up the client is the same as setting up the simple RPC client with additional configurations. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

>**Tip:** You may need to change the trusted certificate file path in the code below.

   ::: code grpc_client_oauth2_refresh_token_grant_type.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start the [OAuth2 service](/learn/by-example/grpc-service-oauth2/).

   ::: out grpc_client_oauth2_refresh_token_grant_type.out :::
