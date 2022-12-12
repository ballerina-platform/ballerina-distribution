# WebSocket client - Timeout

The `websocket:Client` configured with timeouts can gracefully handle timeouts that happen in the running applications. Handshake timeout is the time (in seconds) that a connection waits to get the response of the WebSocket handshake. If the timeout exceeds, then, the connection is terminated with a `HandshakeTimedOut` error. If the configuration value `< 0`, then the value sets to the default value(300). Apart from the `handShakeTimeout`, the WebSocket client also has `readTimeout` and `writeTimeout` configurations to configure idle time to wait to receive a message and to write a message respectively. To enable handshake timeout, provide the `handShakeTimeout` configuration to the client. Use the handshake timeout to gracefully handle response delays that could occur due to network problems or problems in the back end.

::: code websocket_timeout_client.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_timeout_client.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
