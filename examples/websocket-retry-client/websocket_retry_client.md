# WebSocket client - Retry

If the WebSocket client lost the connection due to some transient failure such as momentary loss of network connectivity or temporary unavailability of a service, it automatically tries to reconnect to the given backend. The client only retries when there is a connection error at the handshake phase or if an abnormal closure with the status code(1006) receives once the connection is upgraded to a WebSocket connection. The connection closures with mutual acknowledgements will not be retried. If the maximum reconnect attempt is reached it gives up on the connection. 

::: code websocket_retry_client.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_retry_client.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
