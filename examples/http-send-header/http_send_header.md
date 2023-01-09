# HTTP service - Sending header

The headers are used to send additional details along with the payload. When sending customized headers from the HTTP service, the easiest way is to define them in the `http:StatusCodeResponse` record. The `header` field accepts `map<string|int|boolean|string[]|int[]|boolean[]>` as the header value type.

::: code http_send_header.bal :::

Run the service as follows.

::: out http_send_header.server.out :::

Invoke the HTTP GET resource by executing the following cURL command in a new terminal.

::: out http_send_header.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
