# HTTP client - Query parameter

The `http:Client` can send query parameters mentioned in the method invocation along with the request URL. Each query parameter can be stated as a key-value pair. When the request is sent, the key-value pairs are appended to the request path (e.g., `?foo=bar`). The supported types are `string`, `int`, `float`, `boolean`, `decimal`, and `array` types of the aforementioned types. Use this when invoking endpoints that expect query parameters.

::: code http_client_query_parameter.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Query parameter](/learn/by-example/http-query-parameter/) example.

Run the client program by executing the following command.

::: out http_client_query_parameter.out :::

Furthermore, a `post` request with a query parameter can be sent as shown below.

::: code http_client_query_parameter_post.bal :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
