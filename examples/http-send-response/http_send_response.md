# REST service - Send response

Returning an `anydata` type from the resource method results in an HTTP response, where the returned value becomes the body. If the returned type is `nil`, then a `202 Accepted` response is returned to the client without the body. Otherwise, the response contains the returned value as the payload, and the `Content-type` header is inferred from the return type. In addition, the response status code is `201 Created` for `POST` resources and `200 Ok` for other resources. Furthermore, the `@http:Payload` annotation on the return type can be used to override the `Content-type` header. Returning an `anydata` type from the resource method is useful when the desired payload with the default status code and headers needs to be sent as the response.

::: code http_send_response.bal :::

Run the service as follows.

::: out http_send_response.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_response.client.out :::

>**Tip:** You can invoke the above service via the [Payload data binding client](/learn/by-example/http-client-data-binding/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service return types - Specification](/spec/http/#235-return-types)
