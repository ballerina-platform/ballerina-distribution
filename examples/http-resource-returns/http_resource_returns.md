# Typed resource responses

The resource method can return `anydata` type, an `http:Response` object, `StatusCodeResponse` records along with
`error?`. Instead of using an `http:Caller`, the response can be sent similarly by returning from the method.
When returning `anydata`, the `@http:Payload` annotation can be used to specify the `Content-type` of the response
additionally. Otherwise, the default content type of the respective return value type will be added.
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_resource_returns.bal :::

::: out http_resource_returns.client.out :::

::: out http_resource_returns.server.out :::