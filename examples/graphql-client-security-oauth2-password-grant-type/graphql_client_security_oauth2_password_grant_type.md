# GraphQL client - OAuth2 password grant type

The `graphQL:Client` can connect to a service that is secured with the OAuth2 password grant type by adding the `Authorization: Bearer <token>` header to each request. The required configurations for this grant type can be specified in the `auth` field of the `graphql:ClientConfiguration`. Use this grant type when you need to exchange the user's credentials for an access token.

::: code graphql_client_security_oauth2_password_grant_type.bal :::

## Prerequisites
- Run the GraphQL service given in the [OAuth2 service](/learn/by-example/graphql-service-oauth2/) example.

Run the client program by executing the command below.

::: out graphql_client_security_oauth2_password_grant_type.out :::

## Related links
- [`graphql:OAuth2PasswordGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/OAuth2PasswordGrantConfig)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [GraphQL client OAuth2 password grant type - Specification](/spec/graphql/#12242-password-grant-type)
