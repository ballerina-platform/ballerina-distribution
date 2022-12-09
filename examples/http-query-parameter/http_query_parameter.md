# REST service - Query parameter

The `http` module provides first class support for reading URL query parameters as resource method argument. The supported types are `string`, `int`, `float`, `boolean`, `decimal`, and the `array types` of the aforementioned types. The query param type can be nilable (e.g., (`string? bar`)). The request also provide certain method to retrieve query param at their convenience.

::: code http_query_parameter.bal :::

Run the service as follows.

::: out http_query_parameter.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_query_parameter.client.out :::

>**Tip:** You can invoke the above service via the client given in the [HTTP client - Query parameter](/learn/by-example/http-client-query-parameter/) example.

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service query parameter - Specification](/spec/http/#2343-query-parameter)
