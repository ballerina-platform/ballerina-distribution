# Client - OAuth2 JWT Bearer grant type

A client, which is secured with an OAuth2 JWT bearer grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2JwtBearerGrantConfig` to the `auth` configuration of the client.

For more information on the underlying module, see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

   ::: code grpc_client_oauth2_jwt_bearer_grant_type.bal :::

4. Execute the commands below to build and run the 'client' package.
   
   ::: out grpc_client_oauth2_jwt_bearer_grant_type.out :::

You may need to change the trusted certificate file path.

As a prerequisite, start a sample service secured with OAuth2.
