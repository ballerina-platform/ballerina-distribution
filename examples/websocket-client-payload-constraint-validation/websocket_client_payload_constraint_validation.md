# WebSocket client - Payload constraint validation

Through client payload constraint validation, the receiving message can be validated according to the defined constraints. The constraint validation happens along with the data binding step. If the validation fails, an error will be returned with the validation details.

::: code websocket_client_payload_constraint_validation.bal :::

## Prerequisites
- Run the WebSocket service given in the [Send/Receive message](/learn/by-example/websocket-basic-sample/) example.

Run the client program by executing the command below.

::: out websocket_client_payload_constraint_validation.out :::

## Related links
- [`websocket:Client` client object - API documentation](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client)
- [`websocket:Client` - Specification](/spec/websocket/#4-client)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
