# WebSocket service - Error handling

The Ballerina `websocket` module allows returning errors from the `get` resource and remote methods. The initial WebSocket upgrade service can do various validations. For instance, origin checking and canceling the WebSocket handshake by returning an `error` from the get resource if the validation fails. In this case, it results in a `400 Bad Request` HTTP response, which is the default response. If the returned error is a `websocket:AuthzError`, or a `websocket:AuthnError`, `403 Forbidden` and `401 Unauthorized` HTTP responses are returned respectively. Once the connection is upgraded to a WebSocket connection, if an error is returned from a remote method in the `websocket:Service`, the error is printed on the server terminal along with the stack-trace and it continues to receive messages. Use `do/fail` block to catch and handle the error when needed.
 
::: code websocket_service_error_handling.bal :::

Run the service by executing the command below.

::: out websocket_service_error_handling.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).

## Related links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket service - Specification](/spec/websocket/#3-service-types)
- [Check semantics - Example](/learn/by-example/check-semantics/)
