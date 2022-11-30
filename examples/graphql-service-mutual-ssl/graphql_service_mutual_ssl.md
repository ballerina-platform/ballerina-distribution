# GraphQL service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

::: code graphql_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out graphql_service_mutual_ssl.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - Mutual SSL](/learn/by-example/graphql-client-security-mutual-ssl/) example.

## Related links
- [`graphql:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerConfiguration)
- [`graphql:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerSecureSocket)
- [`graphql` mutual SSL - Specification](/spec/graphql/#1122-mutual-ssl)

