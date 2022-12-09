# REST service - Send response

The resource method can return `anydata` type. In that case, the `Content-type` header of the response is automatically infered from the return type. Additionally, the `@http:Payload` annotation on the return type can be used to overwrite the `Content-type`. The resource function can also return `error`. In that case, a `500 Internal Server Error` will be returned with the error message in the body.

::: code http_send_response.bal :::

Run the service as follows.

::: out http_send_response.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_response.client.out :::

>**Tip:** You can invoke the above service via the [Payload data binding client](/learn/by-example/http-client-data-binding/).

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service return types - Specification](/spec/http/#235-return-types)
