# REST service - Send response

Returning an `anydata` type from the resource method results in an HTTP response where the returned value will become the body.
If the returned type is `nil`, then a `202 Accepted` response will be returned to the client without the body. Otherwise, the response will have the returned value as the body, and the `Content-type` header will be inferred from the return type and added to the response. In addition, the response will be `201 Created` for `POST` resources and `200 Ok` for other resources. Furthermore, the `@http:Payload` annotation on the return type can be used to overwrite the `Content-type` header.
Return `anydata` type from the resource method when you want to send the desired payload with default status code and headers.

::: code http_send_response.bal :::

Run the service as follows.

::: out http_send_response.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_response.client.out :::

>**Tip:** You can invoke the above service via the [Payload data binding client](/learn/by-example/http-client-data-binding/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service return types - Specification](/spec/http/#235-return-types)
