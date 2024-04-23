# SOAP client security - SSL/TLS

The `soap` client can be configured to apply HTTP security configurations using the `httpConfig` parameter. Here, it demonstrates applying an SSL certificate to establish an HTTPS connection between the server and the client. The SOAP client can support all client security configurations supported by the HTTP client.

::: code soap_client_security_ssl_tls.bal :::

Run the program by executing the following command.

::: out soap_client_security_ssl_tls.out :::

## Related links

- [`soap` module - API documentation](https://central.ballerina.io/ballerina/soap/)
- [HTTP client security - Specification](https://ballerina.io/spec/http/#2411-security)
- [`soap` - Specification](/spec/soap)
