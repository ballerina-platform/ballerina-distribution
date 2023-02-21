# TCP service - SSL/TLS 

The `tcp:Listener` configured with allows you to expose a connection secured with one-way SSL/TLS. A `tcp:Listener` secured with SSL/TLS is created by providing the `secureSocket` configurations which require the server's certificate as the `certFile` and the server's private key as the `keyFile`. Use this to interact with TCP clients or implement high-level protocols based on TLS-encrypted secured TCP connection.

::: code tcp_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out tcp_service_ssl_tls.out :::

>**Tip:** You can invoke the above service via the [TCP SSL/TLS client](/learn/by-example/tcp-client-ssl-tls/).

## Related links
- [`tcp` module - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [TCP SSL/TLS - Specification](/spec/tcp/#511-configuring-tls-in-server-side)
