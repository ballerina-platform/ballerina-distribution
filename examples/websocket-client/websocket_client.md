# WebSocket client - Send/Receive message

The WebSocket client connects to a given WebSocket server, and then sends and receives WebSocket frames. A WebSocket client is created by giving the URL of the server. Once connected, `writeMessage` and `readMessage` synchronous methods are used to send and receive messages. Since, they are synchronous methods often used in two different strands. Use this to interact with WebSocket servers or implement user applications based on WebSocket.

::: code websocket_client.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_client.out :::

## Related links
- [`websocket:Client` client object - API documentation](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client)
- [WebSocket Client - Specification](/spec/websocket/#4-client)
