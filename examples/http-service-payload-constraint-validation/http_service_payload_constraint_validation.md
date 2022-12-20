# REST service - Payload constraint validation

The Ballerina `constraint` module allows adding additional constraints to the response payload. The `http` resource method uses the `constraint` module to validate the payload against the given constraints. This validation happens soon after the successful data-binding of the request payload before executing the resource method. The constraints can be added to a given data type using different annotations. If the validation fails, a `400 Bad Request` response is returned to the client with the validation error message. Use this to validate the request payload as the application receives it, which protects the server against unnecessary resource method processing and malicious payloads.

::: code http_service_payload_constraint_validation.bal :::

Run the service program by executing the following command.

::: out http_service_payload_constraint_validation.server.out :::

Invoke the service by executing the following cURL command in a new terminal. Here, an album with a lengthy title is sent to the service.

::: out http_service_payload_constraint_validation.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` module - Specification](/spec/http/)
- [Constraint validation example](/learn/by-example/constraint-validations/)
