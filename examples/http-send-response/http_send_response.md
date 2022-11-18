# Typed resource responses

The resource method can return `anydata` type, an `http:Response` object, `StatusCodeResponse` records along with `error?`. Instead of using an `http:Caller`, the response can be sent similarly by returning from the method. When returning `anydata`, the `@http:Payload` annotation can be used to specify the `Content-type` of the response additionally. Otherwise, the default content type of the respective return value type will be added.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [specification](https://ballerina.io/spec/http/#235-return-types).

::: code http_send_response.bal :::

Run the service as follows.

::: out http_send_response.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_response.client.out :::
