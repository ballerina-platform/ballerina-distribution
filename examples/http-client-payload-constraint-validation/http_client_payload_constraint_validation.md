# HTTP client - Payload constraint validation

The response payload type can define constraints that require validation when obtaining the response. This validation happens automatically during response data binding. If the validation fails, a `http:PayloadValidationError` will be returned with the validation error message.

::: code http_client_payload_constraint_validation.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Payload data binding](/learn/by-example/http-service-data-binding/) example.

Run the client program by executing the following command.

::: out http_client_payload_constraint_validation.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
