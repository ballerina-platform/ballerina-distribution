# HTTP caller

The `http:Caller` represents the endpoint that initiated the call toward a service. It is used to send responses back to the caller. In addition, it also contains meta information such as remote/local addresses. When the `http:Caller` is defined, the resource function return type is constrained to `error?`. `http:Caller` is useful to handle scenarios such as sending status code `100 Continue` or doing some work after sending the response to the caller. In most cases, `http:Caller` is not required as returning from the resource function sends the response back to the caller.

::: code http_caller.bal :::

Run the service as follows.

::: out http_caller.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_caller.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP caller - Specification](/spec/http/#2341-httpcaller)
