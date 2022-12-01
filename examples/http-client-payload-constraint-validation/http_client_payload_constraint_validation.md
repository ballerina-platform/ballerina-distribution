# HTTP client - Payload constraint validation

Through client payload constraint validation, the response payload can be validated according to the defined constraints. The constraint validation happens along with the data binding step. If the validation fails, an `http:PayloadValidationError` will be returned with the validation details.

::: code http_client_payload_constraint_validation.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Payload data binding](/learn/by-example/http-service-data-binding/) example.

Run the client program by executing the following command.

::: out http_client_payload_constraint_validation.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](https://ballerina.io/spec/http/)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
