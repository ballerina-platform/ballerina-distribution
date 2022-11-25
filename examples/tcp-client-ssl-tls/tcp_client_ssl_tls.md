# TCP client - SSL/TLS 

This demonstrates how the Ballerina TCP client can be configured to connect to an SSL/TLS listener through a one-way SSL/TLS connection (i.e., the server is verified by the client). 

::: code tcp_client_ssl_tls.bal :::

## Prerequisites
- Start the [sample service secured with SSL/TLS](/learn/by-example/tcp-service-ssl-tls/).

Run the client program by executing the command below.

::: out tcp_client_ssl_tls.out :::

## Related links
- [`tcp` package - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [`tcp` SSL/TLS - Specification](/spec/tcp/#512-configuring-tls-in-client-side)

