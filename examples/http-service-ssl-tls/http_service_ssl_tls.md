# HTTP service - SSL/TLS

You can use the HTTPS listener to connect to or interact with an HTTPS client. Provide the `http:ListenerSecureSocket` configurations to the server to expose an HTTPS connection.

::: code http_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out http_service_ssl_tls.server.out :::

Invoke the service by executing the cURL command below.

::: out http_service_ssl_tls.client.out :::

>**Info:** You can invoke the above service via the [SSL/TLS client](/learn/by-example/http-client-ssl-tls/).

## Related links
- [`http:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket)
- [HTTP service SSL/TLS - Specification](/spec/http/#921-listener---ssltls)
