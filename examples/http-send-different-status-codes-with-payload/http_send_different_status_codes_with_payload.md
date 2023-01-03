# REST service - Send different status codes with payload

The resource method can return a subtype of the `http:StatusCodeResponse` record type with a body and headers. This type can be created by including a subtype of the `http:StatusCodeResponse` record type. The `body` field represents the response payload, while the `headers` field represents a `map` of the response headers. In addition, the `body` field type can be overridden by a custom record type. Use these custom subtypes if different status code responses need to be sent with custom payload types and headers. Furthermore, defining such records can produce a better representation of the responses in the OpenAPI specification, and using typed records for the `body` field provides compiler validations and better tooling support.

::: code http_send_different_status_codes_with_payload.bal :::

Run the service as follows.

::: out http_send_different_status_codes_with_payload.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_different_status_codes_with_payload.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http:StatusCodeResponse` type - API documentation](https://lib.ballerina.io/ballerina/http/latest/types#StatusCodeResponse)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
