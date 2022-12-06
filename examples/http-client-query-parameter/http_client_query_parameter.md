# HTTP client - Query parameter

The `http` module provides first-class support for specifying URL query parameters as resource method arguments. The supported types are `string`, `int`, `float`, `boolean`, `decimal`, and `array` types of the aforementioned types. The query param type can be `nil` as well.

::: code http_client_query_parameter.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Query parameter](/learn/by-example/http-query-parameter/) example.

Run the client program by executing the following command.

::: out http_client_query_parameter.out :::

Furthermore, a `post` request with query parameter can be sent as shown below.

::: code http_client_query_parameter_post.bal :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
