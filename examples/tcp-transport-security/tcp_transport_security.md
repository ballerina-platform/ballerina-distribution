# Transport security

This demonstrates how the Ballerina TCP client can be configured to connect to an SSL/TLS listener through a one-way SSL/TLS connection (i.e., the server is verified by the client). This example uses the Ballerina TCP listener to host a service and the TCP client sends requests to that listener.

For more information on the underlying module, see the [`tcp` module](https://lib.ballerina.io/ballerina/tcp/latest).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code tcp_transport_security_service.bal :::

Run the service by executing the command below.

::: out tcp_transport_security_service.out :::

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code tcp_transport_security_client.bal :::

Run the client by executing the command below.

::: out tcp_transport_security_client.out :::
