# REST service - Send different status codes with payload

The resource method can return a custom status code response record with a body and headers.
This custom record type can be created by including a subtype of the `http:StatusCodeResponse` record. This record type has a `body` field, which represents the response payload, and a `headers` field, which represents a `map` of the response headers. In addition, the `body` field type can be overwritten by a custom record type.
Use these custom records if you want to send different status code responses with custom payloads and headers. Furthermore, defining such records can produce a better representation of the responses in the OpenAPI specification, and using typed records for the `body` field provides compiler validations and better tooling support.

::: code http_send_different_status_codes_with_payload.bal :::

Run the service as follows.

::: out http_send_different_status_codes_with_payload.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_different_status_codes_with_payload.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http:StatusCodeResponse` type - API documentation](https://lib.ballerina.io/ballerina/http/latest/types#StatusCodeResponse)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
