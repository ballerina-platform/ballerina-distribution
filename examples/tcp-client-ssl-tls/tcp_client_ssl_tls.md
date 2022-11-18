# TCP client - SSL/TLS 

This demonstrates how the Ballerina TCP client can be configured to connect to an SSL/TLS listener through a one-way SSL/TLS connection (i.e., the server is verified by the client). 

For more information on the underlying module, see the [`tcp` module](https://lib.ballerina.io/ballerina/tcp/latest).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code tcp_client_ssl_tls.bal :::

Run the client by executing the command below.

>**Info:** As a prerequisite to running the client, start a [sample service secured with SSL/TLS](/learn/by-example/tcp-service-ssl-tls/).

::: out tcp_client_ssl_tls.out :::
