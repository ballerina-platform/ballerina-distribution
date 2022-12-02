# WebSocket service - Send/Receive message

This explains how the Ballerina WebSocket server interacts with a WebSocket client. Apart from the `onMessage` remote function given in the example, there are few other remote functions to receive different types of WebSocket messages. The `onOpen` remote function is dispatched as soon as the WebSocket handshake is completed and the connection is established, `onPing` and `onPong` remote methods are dispatched upon receiving ping and pong messages respectively, `onIdleTimeout` remote method is dispatched when the idle timeout is reached, `onClose` is dispatched when a close frame with a statusCode and a reason is received and `onError` is dispatched when an error occurs in the WebSocket connection.

::: code websocket_basic_sample.bal :::

Run the service by executing the command below.

::: out websocket_basic_sample.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).

## Related links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket service - Specification](/spec/websocket/#3-service-types)
