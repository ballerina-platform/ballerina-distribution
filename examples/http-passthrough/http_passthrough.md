# HTTP service - Passthrough

The passthrough service forwards the inbound request to the backend and returns the backend response. The passthrough resource is designed to allow all HTTP methods as the accessor is the `default`. Also the rest parameter in the resource path as it allows any request URI to get dispatched. When `forward()` is called on the backend client, it forwards the request that the passthrough resource received to the backend. When forwarding, the request is made using the same HTTP method that was used to invoke the passthrough resource. The `forward()` function returns the response from the backend if there are no errors. This is useful to delegate the functionality to the downstream services.

::: code http_passthrough.bal :::

Run the service as follows.

::: out http_passthrough.server.out :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example as the backend service.

Invoke the service by executing the following cURL command in a new terminal.

::: out http_passthrough.client.out :::

## Related links
- [`forward()` - API documentation](https://lib.ballerina.io/ballerina/http/latest#Client#forward)
- [HTTP service forward method - Specification](/spec/http/#2424-forwardexecute-methods)
