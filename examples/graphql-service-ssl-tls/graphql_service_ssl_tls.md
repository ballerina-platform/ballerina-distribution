# GraphQL service - SSL/TLS

You can use the GraphQL listener to connect to or interact with an HTTPS client. Provide the `graphql:ListenerSecureSocket` configurations to the server to expose an HTTPS connection.

::: code graphql_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out graphql_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - SSL/TLS](/learn/by-example/graphql-client-security-ssl-tls/) example.

## Related links
- [`graphql:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerConfiguration)
- [`graphql:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerSecureSocket)
- [GraphQL service SSL/TLS - Specification](/spec/graphql/#11311-ssltls)
