# HTTP client - Self signed JWT authentication

A client, which is secured with self-signed JWT can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

::: code http_client_self_signed_jwt_authentication.bal :::

## Prerequisites
- Run the GraphQL service given in the [JWT Auth service](/learn/by-example/http-service-jwt-authentication/) example.

Run the client program by executing the command below.

::: out http_client_self_signed_jwt_authentication.out :::

## Related links
- [`http:JwtIssuerConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/JwtIssuerConfig)
- [`jwt` package API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [`Client self signed JWT authentication` - specification](https://ballerina.io/spec/http/#9127-client---self-signed-jwt)
