# TCP client - SSL/TLS 

A TCP client configured with SSL/TLS configurations connects or interacts with a TCP service over an encrypted TLS connection. Provide the `secureSocket` configurations to the client to initiate a secured TCP connection.

::: code tcp_client_ssl_tls.bal :::

## Prerequisites
- Run the TCP service given in the [SSL/TLS](/learn/by-example/tcp-service-ssl-tls/) example.

Run the client program by executing the command below.

::: out tcp_client_ssl_tls.out :::

## Related links
- [`tcp` package - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [TCP SSL/TLS - Specification](/spec/tcp/#512-configuring-tls-in-client-side)

