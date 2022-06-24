# Transport security

This demonstrates how the Ballerina TCP client can be configured to
connect to an SSL/TLS listener through a one-way SSL/TLS connection 
(i.e., the server is verified by the client). This example uses the Ballerina
TCP listener to host a service and the TCP client sends 
requests to that listener.<br/><br/>
For more information on the underlying module,
see the [TCP module](https://docs.central.ballerina.io/ballerina/tcp/latest).

::: code tcp_transport_security_client.bal :::

::: out tcp_transport_security_client.out :::

::: code tcp_transport_security_service.bal :::

::: out tcp_transport_security_service.out :::