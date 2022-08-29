# Client - OAuth2 Password grant type

A client, which is secured with OAuth2 password grant type can be used to connect to a secured service.

The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:OAuth2PasswordGrantConfig` to the `auth` configuration of the client.

For more information on the underlying module, see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

::: code http_client_oauth2_password_grant_type.bal :::

Run the client program by executing the following command.

::: out http_client_oauth2_password_grant_type.out :::
