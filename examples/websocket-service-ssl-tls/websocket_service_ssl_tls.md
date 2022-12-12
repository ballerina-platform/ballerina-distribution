# WebSocket service - SSL/TLS

A WebSocket listener configured with SSL/TLS configurations connects or interacts with a WebSocket client over an encrypted TLS connection. A WebSocket listener secured with TLS/SSL is created by providing the `secureSocket` configurations. Use this to to expose a WSS connection.

::: code websocket_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out websocket_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [SSL/TLS client](/learn/by-example/websocket-client-ssl-tls/).

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)