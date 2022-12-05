# WebSocket client - Timeout

The WebSocket client handshake timeout is used to gracefully handle response delays which could occur due to network problems or the back-end. Handshake timeout is the time (in seconds) that a connection waits to get the response of the WebSocket handshake. If the timeout exceeds, then the connection is terminated with a `HandshakeTimedOut`. If the value < 0, then the value sets to the default value(300). Apart from the `handShakeTimeout` WebSocket client also has `readTimeout` and `writeTimeout` configurations to configure idle time to wait to receive a message and to write a message respectively.

::: code websocket_timeout_client.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_timeout_client.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
