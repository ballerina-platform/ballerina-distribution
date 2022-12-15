# HTTP service - Error handling

Error handling is an integral part of any network program. Errors can be returned by many components such as an interceptor, dispatcher, data binder, security handler, etc. These errors are often handled by a default handler and sent back as `500 InternalSeverError` responses with the error message in the body. This behavior can be changed by adding error interceptors to the interceptor pipeline, which can intercept these errors and handle them as you wish. These error interceptors can be placed anywhere in the interceptor pipeline. When there is an error, execution jumps to the closest error interceptor. Use these error interceptors to handle errors yourself and create appropriate responses for different error types.

::: code http_error_handling.bal :::

Run the service as follows.

::: out http_error_handling.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_error_handling.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service error handling - Specification](/spec/http/#82-error-handling)
