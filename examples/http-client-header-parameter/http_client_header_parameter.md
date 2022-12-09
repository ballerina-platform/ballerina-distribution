# HTTP client - Header parameter

The `http:Client` supports sending outbound request headers along with the request payload.
This headers can be passed as an argument in the client resource method call. The headers should be provided as a `map` where the keys represent the header names and the entries represent the header values. The header values can be `string` or `string[]`.
Use these headers to provide information about the request context, so that the server can tailor the response.

::: code http_client_header_parameter.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Header parameter](/learn/by-example/http-header-parameter/) example.

Run the client program by executing the following command.

::: out http_client_header_parameter.out :::

Furthermore, a `post` request with header parameter can be sent as shown below.

::: code http_client_header_parameter_post.bal :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
