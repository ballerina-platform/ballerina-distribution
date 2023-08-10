# HTTP service - Sending header

The headers are used to send additional details along with the payload. To send custom headers, it is best to create a subtype of the relevant `http:StatusCodeResponse` record by specifying the required header. Creating a subtype helps accurately generate the OpenAPI specification which then can be used to generate the relevant clients. The type of the header can be one of `string`, `int`, `boolean`, `string[]`, `int[]` or `boolean[]`.

::: code http_send_header.bal :::

Run the service as follows.

::: out http_send_header.server.out :::

Invoke the HTTP GET resource by executing the following cURL command in a new terminal.

::: out http_send_header.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
