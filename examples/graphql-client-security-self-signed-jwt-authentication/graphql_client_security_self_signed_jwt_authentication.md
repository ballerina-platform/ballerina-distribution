# GraphQL client - Self signed JWT authentication

The `graphql:Client` can connect to a service that is secured with self-signed JWT by adding the `Authorization: Bearer <token>` header by passing the `graphql:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

::: code graphql_client_security_self_signed_jwt_authentication.bal :::

## Prerequisites
- Run the GraphQL service given in the [JWT Auth service](/learn/by-example/graphql-service-jwt-auth/) example.

Run the client program by executing the command below.

::: out graphql_client_security_self_signed_jwt_authentication.out :::

## Related links
- [`graphql:JwtIssuerConfig` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/JwtIssuerConfig)
- [`jwt` module - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [GraphQL client self signed JWT authentication - Specification](/spec/graphql/#1123-self-signed-jwt-authentication)
