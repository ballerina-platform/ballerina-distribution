# HTTP service - Request interceptor

The `http:RequestInterceptor` is used to intercept the request and execute custom logic. A `RequestInterceptor` is a service object with only one resource method, which is executed before dispatching the request to the actual resource in the target service. This resource method can have parameters just like a usual resource method in an `http:Service`. 

A `RequestInterceptor` can be created from a service class, which includes the `http:RequestInterceptor` service type. Then, this service object can be engaged at the listener level by providing a function implementation of `http:CreateInterceptorsFunction` to the `interceptors` field in the `http:ListenerConfiguration` or at the service level by declaring a `http:InterceptableService` object. 

These accept an interceptor service object or an array of interceptor service objects as the interceptor pipeline, and the interceptors are executed in the order in which they are placed in the pipeline. Use `RequestInterceptors` to execute common logic such as logging, header manipulation, state publishing, etc., for inbound requests.

::: code http_request_interceptor.bal :::

Run the service as follows.

::: out http_request_interceptor.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_request_interceptor.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example by adding the required header to the request.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service request interceptor - Specification](/spec/http/#811-request-interceptor)
