# REST service - Send different status codes

In addition to returning `StatusCodeResponse` constants, the resource method can return `StatusCodeResponse` record that contains response headers and payload. Defining a custom record including the `StatusCodeResponse` can produce a better representation of the response in the OpenAPI specification. In addition to that, these records can be reused to make the design consistent.

::: code http_send_different_status_codes.bal :::

Run the service as follows.

::: out http_send_different_status_codes.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_different_status_codes.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
