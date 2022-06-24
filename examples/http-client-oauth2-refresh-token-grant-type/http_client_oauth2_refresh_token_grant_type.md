# Client - OAuth2 Refresh Token grant type

A client, which is secured with an OAuth2 refresh token grant type can be
used to connect to a secured service.<br/>
The client is enriched with the `Authorization: Bearer <token>` header by
passing the `http:OAuth2RefreshTokenGrantConfig` to the `auth`
configuration of the client.<br/><br/>
For more information on the underlying module,
see the [OAuth2 module](https://docs.central.ballerina.io/ballerina/oauth2/latest/).

::: code http_client_oauth2_refresh_token_grant_type.bal :::

::: out http_client_oauth2_refresh_token_grant_type.out :::