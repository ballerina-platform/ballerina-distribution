# HTTP caller

The caller represents the endpoint that initiated the call toward a service. It contains remote/local addresses and uses to send out responses primarily. In addition to that, advanced scenarios such as redirect, continue are handled using the `http:Caller`. When the caller is defined, the resource function return type limits only to `error?`. If you need to execute some logic even after responding, the `http:Caller` respond method is useful compared to value returns as the flow continues.

::: code http_caller.bal :::

Run the service as follows.

::: out http_caller.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_caller.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP caller - Specification](/spec/http/#2341-httpcaller)
