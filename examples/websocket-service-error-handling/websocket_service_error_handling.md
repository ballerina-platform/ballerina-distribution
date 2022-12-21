# WebSocket service - Error handling

The Ballerina `websocket` module allows returning errors from the `get` resource and `remote` methods. In the initial WebSocket upgrade service, you can do validations like origin checking and cancel the WebSocket handshake by returning an error from the `get` resource if the validation fails. Once the connection is upgraded to a WebSocket connection, if an error is returned from a remote method in the `websocket:Service`, the error is printed on the server terminal along with the stack trace. Use `do on fail` to catch and handle the error.
 
::: code websocket_service_error_handling.bal :::

Run the service by executing the command below.

::: out websocket_service_error_handling.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).

## Related links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket service - Specification](/spec/websocket/#3-service-types)
- [Check semantics - Example](/learn/by-example/check-semantics/)
