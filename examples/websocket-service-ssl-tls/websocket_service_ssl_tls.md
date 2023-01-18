# WebSocket service - SSL/TLS

The `websocket:Listener` configured with SSL/TLS allows you to expose a connection secured with one-way SSL/TLS. A `websocket:Listener` secured with TLS/SSL is created by providing the `secureSocket` configurations which require the server's public certificate as the `certFile` and the server's private key as the `keyFile`. Use this to expose a WSS connection.

::: code websocket_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out websocket_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [SSL/TLS client](/learn/by-example/websocket-client-ssl-tls/).

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)