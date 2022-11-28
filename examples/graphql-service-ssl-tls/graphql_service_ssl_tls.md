# GraphQL service - SSL/TLS

You can use the GraphQL listener to connect to or interact with an HTTPS client. Provide the `graphql:ListenerSecureSocket` configurations to the server to expose an HTTPS connection.

::: code graphql_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out graphql_service_ssl_tls.server.out :::

## Related links
- [`graphql:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerConfiguration)
- [`graphql:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerSecureSocket)
- [`graphql` SSL/TLS - Specification](/spec/graphql/#1121-ssltls)
