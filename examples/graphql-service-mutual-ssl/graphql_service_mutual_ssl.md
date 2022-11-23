# GraphQL service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

>**Tip:** You may need to change the certificate file path, private key file path, and trusted certificate file path.

::: code graphql_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out graphql_service_mutual_ssl.server.out :::

## Related Links
- [`graphql` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest).
- [`graphql` mutual SSL - Specification](/spec/graphql/#1122-mutual-ssl).

