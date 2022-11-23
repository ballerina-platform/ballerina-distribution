# WebSocket service - SSL/TLS

You can use the WebSocket listener to connect to or interact with an WebSocket client. Provide the `websocket:ListenerSecureSocket` configurations to the server to expose an WSS connection.

::: code websocket_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out websocket_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [sample SSL/TLS client](/learn/by-example/websocket-client-ssl-tls/).

## Related Links
- [`websocket` - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`websocket` SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)