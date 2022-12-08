# REST service - Payload constraint validation

The request payload type can define constraints that require validation before responding. This validation happens automatically in the resource methods during data binding. If the validation fails, a 400 Bad Request response will be returned to the client with the validation error message.

::: code http_service_payload_constraint_validation.bal :::

Run the service program by executing the following command.

::: out http_service_payload_constraint_validation.server.out :::

Invoke the service by executing the following cURL command in a new terminal. Here, an album with a lengthy title is sent to the service.

::: out http_service_payload_constraint_validation.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
