# HTTP service - Error handling

The Ballerina `http` module allows returning `error`s from the resource method. Therefore, application logic written inside a resource method could propagate errors from the resource method to the `http:Listener`. Though there are many ways to propagate errors, the most common way is to use the `check` keyword. `http:Listener` intercepts these errors and sends a `500 Internal Server Error` response with the error message in the payload. In addition, it logs the error with the stack trace in the console. Users can take control of this behavior by adding a `do/fail` block in the resource method and handling the errors themselves. When there is a repetition of error handling logic in the resource method, the repetition can be avoided by moving the logic to an Error handler interceptor.

>**Note:** Errors originating from the `http:Listener` itself due to resource not found, data-binding, authorization, etc are converted into respective status codes such as `500 Internal Server Error`, `400 Bad Request`, `401 Unauthorized`, etc. Again, users can take control of this behavior by adding an Error handler interceptor.

::: code http_default_error_handling.bal :::

Run the service as follows.

::: out http_default_error_handling.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_default_error_handling.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP error handling - Specification](/spec/http/#82-error-handling)
