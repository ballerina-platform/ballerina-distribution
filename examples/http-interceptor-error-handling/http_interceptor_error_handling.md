# Interceptor Error Handling

Errors that occurred in the request-response pipeline can be intercepted and handled
by `ResponseErrorInterceptors`. In addition, a `RequestErrorInterceptor` 
can be used to handle the errors that occurred in the request interceptor execution
path. The `RequestErrorInterceptor` can send a response message according to the 
error just like a `ResponseErrorInterceptor`. Moreover, it can modify the 
request and dipatch it to the target service.
  For more information, see the [HTTP module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_interceptor_error_handling.bal :::

::: out http_interceptor_error_handling.client.out :::

::: out http_interceptor_error_handling.server.out :::