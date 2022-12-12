# HTTP client - Send request/Receive response

The `http:Client` is used to connect and interact with an HTTP server. The client is instantiated with the service URL and it will use resource methods to interact with the backend service. The standard HTTP methods `get`, `post`, `put`, `patch`, `delete`, `head`, and `options` are available as resource methods. A resource method can be invoked by providing required arguments and the relevant HTTP verb after the `->`. Since HTTP `get` is the default resource method the verb is not mandatory when accessing an HTTP `get` resource.

::: code http_client_send_request_receive_response.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_send_request_receive_response.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client - Specification](/spec/http/#24-client)
