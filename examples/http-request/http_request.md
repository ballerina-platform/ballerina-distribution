# HTTP request

The `http:Request` represents the incoming/outgoing message over the network. In HTTP service, the `http:Request` can be defined as a resource function argument to capture the incoming message. During the runtime, the `http:Listener` populates properties, headers and payload to the `http:Request` object to be consumed within the resource scope. When the `http:Request` is used with the `http:Client`, the object should be created and populated by the user which represents the outgoing message. The support functions associated with `http:Request` such as getXXXPayload(), getCookies(), getHeader(),.. etc. help developers to explore more of the transport message. This is useful to handle advanced scenarios such as cookie, multipart, and 100-continue where the `http:Request` is mandatory.

::: code http_request.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_request.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP request - Specification](/spec/http/#6-request-and-response)