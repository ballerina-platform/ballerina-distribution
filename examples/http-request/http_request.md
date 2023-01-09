# HTTP request

The headers are used to send additional details along with the payload. When sending customized headers via the `http:Client`, define the header map in the resource invocation. The `header` argument accepts `map<string|string[]>` as the header value type.

::: code http_client_custom_header.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_custom_header.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
