# HTTP service - Request interceptor

Interceptors are used to execute some common logic such as logging, header manipulation, state publishing, etc. for all the inbound requests and outbound responses. A  `RequestInterceptor` can be used to intercept the request and execute some custom logic. `RequestInterceptors` have a resource method, which will be executed before dispatching the request to the actual resource in the target service.

::: code http_request_interceptor.bal :::

Run the service as follows.

::: out http_request_interceptor.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_request_interceptor.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service request interceptor - Specification](/spec/http/#811-request-interceptor)
