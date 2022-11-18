# Retry client

If the WebSocket client lost the connection due to some transient failure, it automatically tries to reconnect to the given backend. If the maximum reconnect attempt is reached it gives up on the connection. 

For more information on the underlying module, see the [`websocket` module](https://lib.ballerina.io/ballerina/websocket/latest/).

>**Info:** As a prerequisite to running the client, start a sample WebSocket service, which sends a message to the client upon upgrading to a WebSocket connection.If you are using a Ballerina WebSocket server, you can send a message to the client in the `onOpen` resource. The client will first connect to the server and then it will wait for 5 seconds to give time for the server to shut down. Start the server after 5 seconds so that the client will start retrying to connect to the server and read messages.

::: code websocket_retry_client.bal :::

::: out websocket_retry_client.out :::