# REST service - Query parameter

The query parameter in the resource argument represents the query segment of the request URL. The argument name should be the key of the query, and its value will be mapped during the runtime by extracting from the URL. The query parameter does not need any additional annotation. The supported types are `string`, `int`, `float`, `boolean`, `decimal`, and `array` types of the aforementioned types. The query parameter type can be nilable (e.g., (`string? bar`)) and defaultable (e.g., (`string? bar = "hello"`)). When a request contains query segments, retrieving them as resource arguments is much simpler and well-recommended. Alternatively, the `http:Request` also provides related methods to retrieve query parameters.

::: code http_query_parameter.bal :::

Run the service as follows.

::: out http_query_parameter.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_query_parameter.client.out :::

>**Info:** You can invoke the above service via the client given in the [HTTP client - Query parameter](/learn/by-example/http-client-query-parameter/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service query parameter - Specification](/spec/http/#2343-query-parameter)
