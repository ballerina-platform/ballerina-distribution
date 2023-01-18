# HTTP service - Response interceptor

The `http:ResponseInterceptor` is used to intercept the response and execute some custom logic. A `ResponseInterceptor` is a service object with a remote method called `interceptResponse`, which is executed before dispatching the response to the client. A `ResponseInterceptor` can be created from a service class, which includes the `http:ResponseInterceptor` service type. Then, this service object can be engaged at the listener level or service level by using the `interceptors` field in the configurations. This field accepts an array of interceptor service objects as an interceptor pipeline, and the interceptors are executed in the order in which they are placed in the pipeline. Use `ResponseInterceptors` to execute some common logic such as logging, header manipulation, state publishing, etc., for all outbound responses.

::: code http_response_interceptor.bal :::

Run the service as follows.

::: out http_response_interceptor.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_response_interceptor.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service response interceptor - Specification](/spec/http/#812-response-interceptor)
