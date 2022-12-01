# HTTP client - Self signed JWT authentication

A GraphQL client, which is secured with self-signed JWT can be used to connect to a secured GraphQL service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `graphql:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

This example shows how to send a GraphQL request with self-signed JWT Authentication.

::: code graphql_client_security_self_signed_jwt_authentication.bal :::

## Prerequisites
- Run the GraphQL service given in the [JWT Auth service](/learn/by-example/graphql-service-jwt-auth/) example.

Run the client program by executing the command below.

::: out graphql_client_security_self_signed_jwt_authentication.out :::

## Related links
- [`graphql:JwtIssuerConfig` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/JwtIssuerConfig)
- [`jwt` package API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [`graphql` Self-signed JWT authentication - Specification](/spec/graphql/#1123-self-signed-jwt-authentication)
