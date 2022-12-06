# REST service - Send different status codes with payload

In addition to returning `StatusCodeResponse` constants, the resource method can return `StatusCodeResponse` record that contains response headers and payload. Defining a custom record type including the `StatusCodeResponse` can produce a better representation of the response in the OpenAPI specification. In addition to that, using typed records provides compiler validations and better tooling support.

::: code http_send_different_status_codes_with_payload.bal :::

Run the service as follows.

::: out http_send_different_status_codes_with_payload.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_different_status_codes_with_payload.client.out :::

## Related links
- [`http:StatusCodeResponse` type - API documentation](https://lib.ballerina.io/ballerina/http/latest/types#StatusCodeResponse)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
