# HTTP client - Payload constraint validation

The Ballerina `constraint` module allows you to add additional constraints to the response payload. The `http:Client` uses the `constraint` module to validate the payload against the given constraints. This validation happens soon after the successful data-binding of the response payload. The constraints can be added to a given data type using different annotations. If the validation fails, an `http:PayloadValidationError` is returned with the validation error message. Use this to validate the response payload as the application program receives it, which allows you to guard against unnecessary processing and malicious payloads.

::: code http_client_payload_constraint_validation.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Payload data binding](/learn/by-example/http-service-data-binding/) example.

Run the client program by executing the following command.

::: out http_client_payload_constraint_validation.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` module - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
