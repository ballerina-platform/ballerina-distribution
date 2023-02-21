# HTTP client - Payload data binding

The `http:Client` payload data-binding allows directly binding the response payload to a given subtype of `anydata`. It does this by mapping a given HTTP content-type to one or more Ballerina types. For instance, `text/plain` is mapped to `string`, whereas `application/json` is mapped to `json`, `record`, etc. The client data-binding can be used by simply assigning the resource method’s returned value to the declared variable. If the response is anything other than 2xx, an `error` is returned and no data-binding is performed. If there is no mapping between the given Ballerina type and the response content-type, again an `error` is returned. Use this when the application is only interested in the response payload but not the headers. When the response payload is JSON, the `record` type is preferred to the `json` type as it provides compile-time validations, better readability, and improved tooling support.

::: code http_client_data_binding.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_data_binding.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client return types - Specification](/spec/http/#243-client-action-return-types)
