# HTTP client - Payload data binding

HTTP Client payload data binding feature allows accessing the response payload directly without manipulating the `http:Response` object. The response payload type is inferred from the contextually expected type or the `targetType` argument. `anydata` type or `http:Response` is expected as the expected-type or the `targetType` along with `error` type. When the client payload data binding is expected, the HTTP error responses (4xx, 5xx) will be categorized as an `error` (`http:ClientRequestError`, `http:RemoteServerError`) of the client's remote operation. If the expected payload type is not compatible with the response payload type an `http:ClientError` will be returned. Use this to access the response payload directly when the response payload type is known beforehand. 

::: code http_client_data_binding.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_data_binding.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client return types - Specification](/spec/http/#243-client-action-return-types)
