# WebSocket client - Retry

The `websocket:Client` with enabled `retry` automatically tries to reconnect to the given backend. The client only retries when there is a connection error at the handshake phase or if an abnormal closure with the status code(1006) is received once the connection is upgraded to a WebSocket connection. The connection closures with mutual acknowledgments will not be retried. If the maximum reconnect attempt is reached, it stops the connection. A `websocket:Client` that retries upon failures is created by providing the `retry` configurations to the client. Use this to re-establish the connection, in cases like the WebSocket client lost the connection due to some transient failure such as a momentary loss of network connectivity or a temporary unavailability of a service.

::: code websocket_retry_client.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_retry_client.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
