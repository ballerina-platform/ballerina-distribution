# HTTP service - SSL/TLS

An `http:Listener` can be configured to communicate through HTTPS. To secure an `http:Listener` using HTTPS, the listener needs to be configured with a certificate file and a private key file. These configurations can be provided through the `securedSocket` field of the `http:ListenerConfiguration`. This field accepts an `http:ListenerSecureSocket` record, which provides the SSL-related configurations. Use this to secure the communication and data transfer between the server and the client.

::: code http_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out http_service_ssl_tls.server.out :::

Invoke the service by executing the cURL command below.

::: out http_service_ssl_tls.client.out :::

>**Tip:** You can invoke the above service via the [SSL/TLS client](/learn/by-example/http-client-ssl-tls/).

## Related links
- [`http:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket)
- [HTTP service SSL/TLS - Specification](/spec/http/#921-listener---ssltls)
