# GraphQL service - SSL/TLS

The `graphql:Listener` can be configured to communicate through HTTPS by providing a certificate file and a private key file. The certificate and the key can be provided through the `secureSocket` field of the `graphql:ListenerConfiguration`. Use this to secure the communication and data transfer between the server and the client.

::: code graphql_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out graphql_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - SSL/TLS](/learn/by-example/graphql-client-security-ssl-tls/) example.

## Related links
- [`graphql:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerConfiguration)
- [`graphql:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerSecureSocket)
- [GraphQL service SSL/TLS - Specification](/spec/graphql/#12311-ssltls)
