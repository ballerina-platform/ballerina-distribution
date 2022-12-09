# HTTP client - Payload constraint validation

The Ballerina [`constraint`](https://lib.ballerina.io/ballerina/constraint/latest/) module allows you to add constraints on a given data-type using different annotations. Use these constraint annotations on the response payload type if you want to add additional validations to the response. The `http:Client` uses the [`constraint`](https://lib.ballerina.io/ballerina/constraint/latest/) package to validate the payload against the given constraints. This validation happens soon after the successful data-binding of the response payload. If the validation fails, `http:PayloadValidationError` will be returned with the validation error message. Use this to validate the response payload as the application program receives it, which allows you to guard against unnecessary processing and malicious payloads.

::: code http_client_payload_constraint_validation.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Payload data binding](/learn/by-example/http-service-data-binding/) example.

Run the client program by executing the following command.

::: out http_client_payload_constraint_validation.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
