# HTTP client - Send request/Receive response

The HTTP client can be used to connect to and interact with an HTTP server. The client is instantiated with the URL and uses the resource method to make the network calls. The standard HTTP methods `get`, `post`, `put`, `patch`, `delete`, `head`, and `options` are available as resource methods and can be invoked as same as invoking a remote method. To invoke an HTTP method, the relevant verb and the required arguments can be provided after the `->`. For the `get` method, the verb is not explicitly needed since it will default.

::: code http_client_send_request_receive_response.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_send_request_receive_response.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client - Specification](/spec/http/#24-client)
