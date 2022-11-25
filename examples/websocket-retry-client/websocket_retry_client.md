# WebSocket client - Retry on failure

If the WebSocket client lost the connection due to some transient failure, it automatically tries to reconnect to the given backend. If the maximum reconnect attempt is reached it gives up on the connection. 

::: code websocket_retry_client.bal :::

## Prerequisites
- Start a sample WebSocket service, which sends a message to the client upon upgrading to a WebSocket connection. If you are using a Ballerina WebSocket server, you can send a message to the client in the `onOpen` resource.

Run the client program by executing the command below.

::: out websocket_retry_client.out :::

## Related Links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
