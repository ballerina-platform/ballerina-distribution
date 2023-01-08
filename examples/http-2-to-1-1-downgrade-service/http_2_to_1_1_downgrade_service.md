# HTTP service - HTTP/2 to HTTP/1.1 downgrade

The HTTP service is configured to run over the HTTP/1.1 protocol. So this service will only accept requests received over the HTTP/1.1 protocol. If an HTTP/2-enabled client sends a request to this service, the client will also get downgraded to use HTTP/1.1.

::: code http_2_to_1_1_downgrade_service.bal :::

Run the service as follows.

::: out http_2_to_1_1_downgrade_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_2_to_1_1_downgrade_service.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP resource - Specification](https://ballerina.io/spec/http/#23-resource)
