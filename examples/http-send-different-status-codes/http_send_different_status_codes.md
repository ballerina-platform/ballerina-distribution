# REST service - Send different status codes

The resource method can return `StatusCodeResponse` record that contains response headers and payload. Ballerina provides built in records for each HTTP status codes. In addition to that, record constants are also available in any modification is not needed for the default values.

::: code http_send_different_status_codes.bal :::

Run the service as follows.

::: out http_send_different_status_codes.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_different_status_codes.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Status code response` - specification](https://ballerina.io/spec/http/#2351-status-code-response)
