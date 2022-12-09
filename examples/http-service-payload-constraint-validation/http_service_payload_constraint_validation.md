# REST service - Payload constraint validation

The Ballerina [`constraint`](https://lib.ballerina.io/ballerina/constraint/latest/) module allows you to add constraints on a given data-type using different annotations. Use these constraint annotations on the request payload type if you want to add additional validations to the request. The `http` resource method uses the [`constraint`](https://lib.ballerina.io/ballerina/constraint/latest/) package to validate the payload against the given constraints. This validation happens soon after the successful data-binding of the request payload before executing the resource method. If the validation fails, a 400 Bad Request response will be returned to the client with the validation error message. Use this to validate the request payload as the application receives it, which allows you to guard against unnecessary resource method processing and malicious payloads.

::: code http_service_payload_constraint_validation.bal :::

Run the service program by executing the following command.

::: out http_service_payload_constraint_validation.server.out :::

Invoke the service by executing the following cURL command in a new terminal. Here, an album with a lengthy title is sent to the service.

::: out http_service_payload_constraint_validation.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` package - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
