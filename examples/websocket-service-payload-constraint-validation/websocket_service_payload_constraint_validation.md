# WebSocket service - Payload constraint validation

The Ballerina constraint package allows you to add additional constraints to the received payload. Through service payload constraint validation, the payload can be validated according to the defined constraints. The constraint validation happens along with the data binding step in the remote function signature parameter. Constraints can be added to a given data type using different annotations. If the validation fails, the `onError` remote function is dispatched with the validation error details. Use this to validate the receiving payload, which allows you to guard against unnecessary processing and malicious payloads.

::: code websocket_service_payload_constraint_validation.bal :::

Run the service by executing the command below.

::: out websocket_service_payload_constraint_validation.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).

## Related links
- [`websocket` package - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket service - Specification](/spec/websocket/#3-service-types)
- [Constraint BBE](/learn/by-example/constraint-validations/)
