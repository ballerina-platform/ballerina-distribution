# GraphQL service - Mutual SSL

The `graphql:Listener` with mutual SSL (mTLS) enabled in it allows exposing a connection secured with mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity. The `graphql:Listener` secured with mutual SSL is created by providing the `secureSocket` configurations, which require the word `require` as the `verifyClient`, the server's public certificate as the `certFile`, the server's private key as the `keyFile`, and the client's certificate as the `cert`. Use this to secure the GraphQL connection over mutual SSL.

::: code graphql_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out graphql_service_mutual_ssl.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - Mutual SSL](/learn/by-example/graphql-client-security-mutual-ssl/) example.

## Related links
- [`graphql:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ListenerConfiguration)
- [`graphql:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ListenerSecureSocket)
- [GraphQL service mutual SSL - Specification](/spec/graphql/#12312-mutual-ssl)
