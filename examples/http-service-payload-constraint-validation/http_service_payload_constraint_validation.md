# REST service - Payload constraint validation

Through service payload constraint validation, the request payload can be validated according to the defined constraints. The constraint validation happens along with the data binding step in the resource signature parameter. If the validation fails, a `400 Bad Request` response will be returned to the client with the validation details.

::: code http_service_payload_constraint_validation.bal :::

Run the service program by executing the following command.

::: out http_service_payload_constraint_validation.server.out :::

Invoke the service by executing the following cURL command in a new terminal. Here, an album which exceeds the constraints are sent to the service.

::: out http_service_payload_constraint_validation.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
