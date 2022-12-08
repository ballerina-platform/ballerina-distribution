# HTTP client - Payload constraint validation

The client level response data binding also validates the payload against any constraints defined on the response payload type. If the validation fails, `http:PayloadValidationError` will be returned with the validation error message. Use this to directly validate the response payload with respect to the defined constraints.

::: code http_client_payload_constraint_validation.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Payload data binding](/learn/by-example/http-service-data-binding/) example.

Run the client program by executing the following command.

::: out http_client_payload_constraint_validation.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
