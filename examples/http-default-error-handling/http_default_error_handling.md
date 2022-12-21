# HTTP service - Error handling

Error handling is an integral part of any network program. The error can be returned or checked from the resource function, interceptor, request dispatcher, or data binder. These errors are often handled by a default handler and sent back as `500 InternalSeverError` responses with the error message in the body. The error is printed on the server terminal along with the stacktrace. This prevents some additional error-handling codes in your program.

>**Note:** Use `on fail` to group several errors together or to customize the `check` error as described in [Check semantics](/learn/by-example/check-semantics/) example. Alternatively, add a response error interceptor as described in [HTTP service - Error handling](/learn/by-example/http-error-handling/) example to more flexibility.

::: code http_default_error_handling.bal :::

Run the service as follows.

::: out http_default_error_handling.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_default_error_handling.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP error handling - Specification](/spec/http/#82-error-handling)
