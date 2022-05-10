# Interceptor Error Handling

Errors that occurred in the request-response pipeline can be intercepted and handled
by `ResponseErrorInterceptors`. In addition, a `RequestErrorInterceptor` 
can be used to handle the errors that occurred in the request interceptor execution
path. The `RequestErrorInterceptor` can send a response message according to the 
error just like a `ResponseErrorInterceptor`. Moreover, it can modify the 
request and dipatch it to the target service.
  For more information, see the [`http` module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-interceptor-error-handling/http_interceptor_error_handling.bal :::

::: out ./examples/http-interceptor-error-handling/http_interceptor_error_handling.client.out :::

::: out ./examples/http-interceptor-error-handling/http_interceptor_error_handling.server.out :::