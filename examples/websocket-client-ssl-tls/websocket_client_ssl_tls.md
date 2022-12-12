# WebSocket client - SSL/TLS

The `websocket:Client` secured with SSL/TLS connects to a given SSL/TLS-secured WebSocket server(WSS). A `websocket:Client` secured with SSL/TLS is created by providing the `secureSocket` configurations which requires server's public certificate as the `cert`. Use this to interact with TLS-encrypted WebSocket servers.

::: code websocket_client_ssl_tls.bal :::

## Prerequisites
- Run the WebSocket service given in the [SSL/TLS](/learn/by-example/websocket-service-ssl-tls/) example.

Run the client program by executing the command below.

::: out websocket_client_ssl_tls.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)
