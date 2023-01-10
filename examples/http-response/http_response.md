# HTTP response

The response represents the outgoing message from a service and the incoming message to a client. A response is used to respond to the caller who initiated the call. Ballerina represents it via the `http:Response` object. Once it is created, headers, payloads, and status code properties should be populated. The `http:Response` can be either returned from the resource or responded to using the `respond` method of `http:Caller`. Also the `http:Response` is one of the return values of the `http:Client` remote/resource invocations. Instead of client data binding, the user can consume the `http:Response` object to explore headers and payload. The support functions associated such as setXXXPayload(), AddCookie(), setHeader(),.. etc. help developers to explore more of the transport message. To handle advanced scenarios such as a cookie, multipart, and redirect, the `http:Response` is useful.

::: code http_response.bal :::

Run the service as follows.

::: out http_response.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_response.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP response - Specification](/spec/http/#6-request-and-response)
