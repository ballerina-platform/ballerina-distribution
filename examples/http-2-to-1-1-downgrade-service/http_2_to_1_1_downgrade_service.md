# HTTP service - HTTP/2 to HTTP/1.1 downgrade

The HTTP service is configured to run over the HTTP/1.1 protocol. Therefore this service only accepts requests received over the HTTP/1.1 protocol. If an HTTP2-enabled client sends a request to this service, the client gets downgraded to use HTTP/1.1. If the listener is configured to communicate over HTTPS, the ALPN negotiation of choosing which protocol to be used over the secure connection is handled internally. This avoids additional round trips and is independent of the application-layer protocols.

::: code http_2_to_1_1_downgrade_service.bal :::

Run the service as follows.

::: out http_2_to_1_1_downgrade_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_2_to_1_1_downgrade_service.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP resource - Specification](https://ballerina.io/spec/http/#23-resource)
