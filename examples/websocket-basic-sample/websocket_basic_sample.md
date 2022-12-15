# WebSocket service - Send/Receive message

The `websocket:Service` allows opening up a port via a `websocket:Listener`. A `websocket:Listener` is created by giving the port number, to which `websocket:Service` is attached. The listener accepts and serves connections from WebSocket clients. The `onMessage` remote method receives incoming WebSocket messages. There are a few other remote methods to receive other types of WebSocket messages. The `onOpen` remote method is dispatched as soon as the WebSocket handshake is completed and the connection is established, `onPing` and `onPong` remote methods are dispatched upon receiving ping and pong messages respectively, `onIdleTimeout` remote method is dispatched when the idle timeout is reached, `onClose` is dispatched when a close frame with a `statusCode` and a `reason` is received and finally the `onError` is dispatched when an error occurs in the WebSocket connection. Use this service to implement user applications where you need to establish two-way communication over the WebSocket protocol.

::: code websocket_basic_sample.bal :::

Run the service by executing the command below.

::: out websocket_basic_sample.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).

## Related links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket service - Specification](/spec/websocket/#3-service-types)
