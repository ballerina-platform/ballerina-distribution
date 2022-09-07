# Response Interceptors

In addition to `RequestInterceptors`, a `ResponseInterceptor` can be used to intercept the response. `ResponseInterceptors` have a remote method, which will be executed before dispatching the response to the client. A collection of these request and response interceptors can be configured as a pipeline at the listener level or service level. 

For more information, see the [`http` module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_response_interceptors.bal :::

Run the service as follows.

::: out http_response_interceptors.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_response_interceptors.client.out :::
