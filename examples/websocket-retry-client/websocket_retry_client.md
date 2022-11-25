# WebSocket client - Retry on failure

If the WebSocket client lost the connection due to some transient failure, it automatically tries to reconnect to the given backend. If the maximum reconnect attempt is reached it gives up on the connection. 

::: code websocket_retry_client.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_retry_client.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
