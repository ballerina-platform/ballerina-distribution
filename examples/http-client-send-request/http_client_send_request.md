# HTTP client - HTTP request object

The `http:Request` object in the HTTP client can be used to handle more complex scenarios like requests with multiparts. This BBE demonstrate how to use `http:Request` object in a client program using a simple use case. 

::: code http_client_send_request.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_send_request.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Client` - specification](https://ballerina.io/spec/http/#24-client)
- [`Request with multiparts` example](/learn/by-example/http-request-with-multiparts/)
