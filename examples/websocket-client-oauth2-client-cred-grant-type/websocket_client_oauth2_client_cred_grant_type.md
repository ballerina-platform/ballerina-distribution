# Client - OAuth2 Client Credentials grant type

A client, which is secured with OAuth2 client credentials grant typecan be used to connect to a secured service.

The client is enriched with the `Authorization: Bearer <token>` header by passing the `websocket:OAuth2ClientCredentialsGrantConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/).

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code websocket_client_oauth2_client_cred_grant_type.bal :::

Run the client program by executing the command below.

>**Info:** As a prerequisite to running the client, start a sample service secured with OAuth2.

::: out websocket_client_oauth2_client_cred_grant_type.out :::