# GraphQL client - SSL/TLS

The `graphql:Client` can be configured to communicate through HTTPS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the `graphql:ClientConfiguration`. Use this to secure the communication between the client and the server.

::: code graphql_client_security_ssl_tls.bal :::

## Prerequisites
- Run the GraphQL service given in the [SSL/TLS](https://ballerina.io/learn/by-example/graphql-returning-record-values) example.

Run the client program by executing the following command.

::: out graphql_client_security_ssl_tls.out :::

## Related links
- [`graphql:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ClientSecureSocket)
- [GraphQL client SSL/TLS - Specification](/spec/graphql/#11321-ssltls)
