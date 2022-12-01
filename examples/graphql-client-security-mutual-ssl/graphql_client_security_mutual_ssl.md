# GraphQL client - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

This example shows how to send a GraphQL request securely using mutual SSL.

::: code graphql_client_security_mutual_ssl.bal :::

## Prerequisites
- Run the GraphQL service given in the [Mutual SSL](https://ballerina.io/learn/by-example/graphql-service-mutual-ssl) example.

Run the client program by executing the following command.

::: out graphql_client_security_mutual_ssl.out :::

## Related links
- [`graphql:ClientSecureSocket` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/ClientSecureSocket)
- [`graphql` mutual SSL - Specification](/spec/graphql/#11322-mutual-ssl)
