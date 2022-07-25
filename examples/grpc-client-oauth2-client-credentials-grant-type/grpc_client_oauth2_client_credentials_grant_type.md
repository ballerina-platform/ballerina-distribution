# Client - OAuth2 Client Credentials grant type

A client, which is secured with OAuth2 client credentials grant type
can be used to connect to a secured service.<br/>
The client metadata is enriched with the `Authorization: Bearer <token>`
header by passing the `grpc:OAuth2ClientCredentialsGrantConfig` for the
`auth` configuration of the client.<br/><br/>
For more information on the underlying module,
see the [OAuth2 module](https://docs.central.ballerina.io/ballerina/oauth2/latest/).

::: code grpc_client.proto :::

::: out grpc_client.out :::

::: code grpc_client_oauth2_client_credentials_grant_type.bal :::

::: out grpc_client_oauth2_client_credentials_grant_type.out :::