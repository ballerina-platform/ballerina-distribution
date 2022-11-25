# HTTP client - SSL/TLS

You can use the HTTPS client to connect or interact with an HTTPS listener. Provide the `http:ClientSecureSocket` configurations to the client to initiate an HTTPS connection.

::: code http_client_ssl_tls.bal :::

## Prerequisites
- Start a [sample service secured with SSL/TLS](learn/by-example/http-service-ssl-tls/).

Run the secure client program by executing the command below.

::: out http_client_ssl_tls.out :::

## Related links
- [`http:ClientSecureSocket` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ClientSecureSocket)
- [`Client SSL/TLS` - specification](https://ballerina.io/spec/http/#923-client---ssltls)
