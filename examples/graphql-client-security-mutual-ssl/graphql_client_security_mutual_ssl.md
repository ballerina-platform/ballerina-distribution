# GraphQL client - Mutual SSL

The `graphql:Client` allows opening up a connection secured with mutual SSL (mTLS), which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity. The `graphql:Client` secured with mutual SSL is created by providing the `secureSocket` configurations, which require the client's public certificate as the `certFile`, the client's private key as the `keyFile`, and the server's certificate as the `cert`. Use this to interact with mTLS-encrypted GraphQL servers.

::: code graphql_client_security_mutual_ssl.bal :::

## Prerequisites
- Run the GraphQL service given in the [Mutual SSL](https://ballerina.io/learn/by-example/graphql-service-mutual-ssl) example.

Run the client program by executing the following command.

::: out graphql_client_security_mutual_ssl.out :::

## Related links
- [`graphql:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ClientSecureSocket)
- [GraphQL client mutual SSL - Specification](/spec/graphql/#12322-mutual-ssl)
