# WebSocket service - SSL/TLS

A WebSocket listener configured with SSL/TLS configurations connect or interact with a WebSocket client over an encrypted TLS connection. Provide the `secureSocket` configurations to expose an WSS connection.

::: code websocket_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out websocket_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [SSL/TLS client](/learn/by-example/websocket-client-ssl-tls/).

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)