# WebSocket service - Payload constraint validation

Through service payload constraint validation, the request payload can be validated according to the defined constraints. The constraint validation happens along with the data binding step in the resource signature parameter. If the validation fails, the `onError` remote function is dispatched with the validation error details.

::: code websocket_service_payload_constraint_validation.bal :::

Run the service by executing the command below.

::: out websocket_service_payload_constraint_validation.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).

## Related links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`websocket` service - Specification](/spec/websocket/#3-service-types)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
