# WebSocket client - SSL/TLS

You can use the WSS client to connect or interact with an WSS listener. Provide the `websocket:ClientSecureSocket` configurations to the client to initiate an WSS connection.

::: code websocket_client_ssl_tls.bal :::

## Prerequisites
- Start the [sample service secured with SSL/TLS](/learn/by-example/websocket-service-ssl-tls/).

Run the client program by executing the command below.

::: out websocket_client_ssl_tls.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`websocket` SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)
