# Error Handling

Error handling is an integral part of any network program. Errors can be returned by many components such as interceptors, dispatcher, data-binder, security handlers, etc. These errors are often handled by a default handler and sent back as error responses with an entity-body. With the introduction of error interceptors, you can intercept  these errors and handle them as you wish. These error interceptors can be placed  anywhere in the interceptor pipeline. When there is an error, the execution jumps to the closest error interceptor.

For more information, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [specification](https://ballerina.io/spec/http/#82-error-handling).

::: code http_error_handling.bal :::

Run the service as follows.

::: out http_error_handling.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_error_handling.client.out :::
