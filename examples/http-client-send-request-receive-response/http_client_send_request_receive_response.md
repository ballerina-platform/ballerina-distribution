# HTTP client - Send request/Receive response

The `http:Client` interacts with an HTTP server. The client is instantiated with the service URL and it uses resource methods to send requests and receive responses from the backend service. The standard HTTP methods `get`, `post`, `put`, `patch`, `delete`, `head`, and `options` are available as resource accessors. A resource method invocation is done by providing the `resource path`, relevant `resource accessor`, and required arguments after the `->`. Since HTTP `get` is the default resource method, the accessor is not mandatory when invoking an HTTP `GET` resource.

::: code http_client_send_request_receive_response.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_send_request_receive_response.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client - Specification](/spec/http/#24-client)
