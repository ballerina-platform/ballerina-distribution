# Service - SSL/TLS

You can use the GraphQL listener to connect to or interact with an HTTPS client. Provide the `graphql:ListenerSecureSocket` configurations to the server to expose an HTTPS connection.

For more information on the underlying module, see the [`graphql` module](https://lib.ballerina.io/ballerina/graphql/latest/).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code graphql_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out graphql_service_ssl_tls.server.out :::