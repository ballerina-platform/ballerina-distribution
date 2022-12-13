# HTTP client - SSL/TLS

An `http:Client` can be configured to communicate through HTTPS. To secure an `http:Client` using HTTPS, the client needs to be configured with a certificate file. This configuration can be provided through the `securedSocket` field of the `http:ClientConfiguration`. This field accepts an `http:ClientSecureSocket` record, which provides the SSL-related configurations. Use this to secure the communication and data transfer between the client and the server.

::: code http_client_ssl_tls.bal :::

## Prerequisites
- Run the HTTP service given in the [SSL/TLS service](/learn/by-example/http-service-ssl-tls/) example.

Run the secure client program by executing the command below.

::: out http_client_ssl_tls.out :::

## Related links
- [`http:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ClientSecureSocket)
- [HTTP client SSL/TLS - Specification](/spec/http/#923-client---ssltls)
