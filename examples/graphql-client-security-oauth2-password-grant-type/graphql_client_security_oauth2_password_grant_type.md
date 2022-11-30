# GraphQL client - OAuth2 password grant type

A GraphQL client, which is secured with OAuth2 password grant type can be used to connect to a secured GraphQL service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `graphql:OAuth2PasswordGrantConfig` to the `auth` configuration of the client.

::: code graphql_client_security_oauth2_password_grant_type.bal :::

## Prerequisites
- Run the GraphQL service given in the [OAuth2 service](/learn/by-example/graphql-service-oauth2/) example.

Run the client program by executing the command below.

::: out graphql_client_security_oauth2_password_grant_type.out :::

## Related links
- [`graphql:OAuth2PasswordGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/OAuth2PasswordGrantConfig)
- [`oauth2` package API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
