# WebSocket client - SSL/TLS

A WebSocket client configured with SSL/TLS configurations connects or interacts with a WebSocket service over an encrypted TLS connection(WSS). Provide the `secureSocket` configurations to the client to initiate a WSS connection.

::: code websocket_client_ssl_tls.bal :::

## Prerequisites
- Run the WebSocket service given in the [SSL/TLS](/learn/by-example/websocket-service-ssl-tls/) example.

Run the client program by executing the command below.

::: out websocket_client_ssl_tls.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)
