# HTTP request

The request represents the incoming message to a service and the outgoing message from a client. A request is used to invoke an endpoint. Ballerina represents it via the `http:Request` object. You can define the request as a resource function argument. During the runtime, the `http:Listener` populates properties, headers and payload to the `http:Request`. When calling backend endpoint, a user-defined `http:Request` can be used. The support functions associated such as getXXXPayload(), getCookies(), getHeader(),.. etc. help developers to explore more of the transport message. To handle advanced scenarios such as cookie, multipart, and 100-continue, the `http:Request` is useful.

::: code http_request.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_request.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP request - Specification](/spec/http/#6-request-and-response)