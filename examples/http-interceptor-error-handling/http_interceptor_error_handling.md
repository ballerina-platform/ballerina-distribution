# HTTP service - Interceptor error handling

Errors that occurred in the request-response flow can be intercepted and handled by `ResponseErrorInterceptors`. In addition, the `http:RequestErrorInterceptor` can be used to handle errors that occurred while executing `RequestInterceptors`. This error interceptor can send a response according to the error, just like a `ResponseErrorInterceptor`. Moreover, it can modify the request and dispatch it to the target service. Use `RequestErrorInterceptors` along with `RequestInterceptors` to validate the request beforehand and handle any errors during this validation.

::: code http_interceptor_error_handling.bal :::

Run the service as follows.

::: out http_interceptor_error_handling.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_interceptor_error_handling.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service error handling - Specification](/spec/http/#82-error-handling)
