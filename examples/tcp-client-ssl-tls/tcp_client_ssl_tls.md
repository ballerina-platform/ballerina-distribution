# TCP client - SSL/TLS 

The `tcp:Client` secured with SSL/TLS connects to a given SSL/TLS-secured TCP server socket, and then sends and receives byte streams. A `tcp:Client` secured with SSL/TLS is created by additionally giving `secureSocket` configurations. Once connected, `writeBytes` and `readBytes` synchronous methods are used to send and receive byte streams over an encrypted TLS connection. Use this to interact with TCP servers or implement high-level protocols based on TLS-encrypted secured TCP connection.

::: code tcp_client_ssl_tls.bal :::

## Prerequisites
- Run the TCP service given in the [SSL/TLS](/learn/by-example/tcp-service-ssl-tls/) example.

Run the client program by executing the command below.

::: out tcp_client_ssl_tls.out :::

## Related links
- [`tcp` package - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [TCP SSL/TLS - Specification](/spec/tcp/#512-configuring-tls-in-client-side)

