# HTTP service - Request/Response object

`http:Request` and `http:Response` objects are Ballerina abstractions for HTTP request and HTTP response respectively. They are considered low-level abstractions which are used to implement high-level abstractions such as data-binding, header mapping, query parameter mapping, etc. They can be used both on the client side and the service side. They are useful when implementing advanced scenarios such as gateways, proxy services, handling multipart requests, etc. In most cases, the `http:Request` and the `http:Response` objects are not needed as higher-level abstractions can do the same thing.

::: code http_request_response.bal :::

Run the service as follows.

::: out http_request_response.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_request_response.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP request and response - Specification](/spec/http/#6-request-and-response)