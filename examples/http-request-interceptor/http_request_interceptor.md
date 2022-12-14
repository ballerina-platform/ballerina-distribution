# HTTP service - Request interceptor

The `http:RequestInterceptor` is used to intercept the request and execute some custom logic. A `RequestInterceptor` is a service object with only one resource method, which is executed before dispatching the request to the actual resource in the target service. A `RequestInterceptor` can be created from a service class, which includes the `http:RequestInterceptor` service type. Then, this service object can be engaged at the listener level or service level by using the `interceptors` field in the configurations. This field accepts an array of interceptor service objects as an interceptor pipeline, and the interceptors are executed in the order in which they are placed in the pipeline. Use `RequestInterceptors` to execute some common logic, such as logging, header manipulation, state publishing, etc., for inbound requests.

::: code http_request_interceptor.bal :::

Run the service as follows.

::: out http_request_interceptor.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_request_interceptor.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service request interceptor - Specification](/spec/http/#811-request-interceptor)
