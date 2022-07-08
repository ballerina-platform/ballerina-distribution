# Interceptors

Interceptors are used to execute some common logic such as logging, header manipulation,
state publishing, etc. for all the inbound requests and outbound responses. A 
`RequestInterceptor` can be used to intercept the request and execute some custom
logic. `RequestInterceptors` have a resource method, which will be executed
before dispatching the request to the actual resource in the target service. In addition,
a `ResponseInterceptor` can be used to intercept the response. `ResponseInterceptors`
have a remote method, which will be executed before dispatching the response to the client.
A collection of these interceptors can be configured as a pipeline at the listener level or service level.
For more information, see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_interceptors.bal :::

::: out http_interceptors.client.out :::

::: out http_interceptors.server.out :::