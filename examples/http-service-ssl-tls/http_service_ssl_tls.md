# HTTP service - SSL/TLS

The `http:Listener` can be configured to communicate through HTTPS by providing a certificate file and a private key file. The certificate and the key can be provided through the `secureSocket` field of the listener configuration. Use this to secure the communication and data transfer between the server and the client.

::: code http_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out http_service_ssl_tls.server.out :::

Invoke the service by executing the cURL command below.

::: out http_service_ssl_tls.client.out :::

>**Tip:** You can invoke the above service via the [SSL/TLS client](/learn/by-example/http-client-ssl-tls/) example.

## Related links
- [`http:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/http/latest#ListenerSecureSocket)
- [HTTP service SSL/TLS - Specification](/spec/http/#921-listener---ssltls)
