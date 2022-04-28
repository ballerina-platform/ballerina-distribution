# Request error interceptor

A `RequestErrorInterceptor` is used to handle the errors that occurred in the interceptor pipeline execution. 
When an error is returned from a `RequestInterceptor` service, the interceptor pipeline execution jumps to the
nearest `RequestErrorInterceptor`. However, if there is no `RequestErrorInterceptor` in the pipeline, then, 
the error response is returned to the client without executing the actual resource in the target service.
For more information, see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-request-error-interceptor/http_request_error_interceptor.bal :::

::: out ./examples/http-request-error-interceptor/http_request_error_interceptor.client.out :::

::: out ./examples/http-request-error-interceptor/http_request_error_interceptor.server.out :::