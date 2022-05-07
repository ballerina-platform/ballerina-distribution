# Retry

If the WebSocket client lost the connection due to some transient failure, it automatically tries to
reconnect to the given backend. If the maximum reconnect attempt is reached it gives up on the connection. <br/><br/>
For more information on the underlying module,
see the [WebSocket module](https://lib.ballerina.io/ballerina/websocket/latest/).

::: code ./examples/websocket-retry-client/websocket_retry_client.bal :::

::: out ./examples/websocket-retry-client/websocket_retry_client.out :::