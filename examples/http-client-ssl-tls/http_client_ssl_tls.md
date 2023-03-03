# HTTP client - SSL/TLS

The `http:Client` can be configured to communicate through HTTPS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the client configuration. Use this to secure the communication between the client and the server.

::: code http_client_ssl_tls.bal :::

## Prerequisites
- Run the HTTP service given in the [SSL/TLS service](/learn/by-example/http-service-ssl-tls/) example.

Run the secure client program by executing the command below.

::: out http_client_ssl_tls.out :::

## Related links
- [`http:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/http/latest#ClientSecureSocket)
- [HTTP client SSL/TLS - Specification](/spec/http/#923-client---ssltls)
