# Query parameter

HTTP module provides first class support for reading URL query parameters as resource method argument.
The supported types are string, int, float, boolean, decimal, and the array types of the aforementioned types. The
query param type can be nilable (e.g., (string? bar)). The request also provide certain method to retrieve query
param at their convenience <br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_query_parameter.bal :::

::: out http_query_parameter.client.out :::

::: out http_query_parameter.server.out :::