# Request interceptor at listener level

The HTTP Listener supports intercepting requests in the request path. It is possible to
define a `RequestInterceptor` service class with a resource function to execute 
custom logic and engage with an HTTP Listener. The request will go through the 
interceptor services before its dispatched to the actual resource in the target 
service. Interceptors engaged at listener level can only have default path. 
For more information, see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-request-interceptor-at-listener/http_request_interceptor_at_listener.bal :::

::: out ./examples/http-request-interceptor-at-listener/http_request_interceptor_at_listener.client.out :::

::: out ./examples/http-request-interceptor-at-listener/http_request_interceptor_at_listener.server.out :::