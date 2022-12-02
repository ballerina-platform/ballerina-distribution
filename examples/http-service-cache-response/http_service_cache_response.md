# HTTP service - Sending cache response

HTTP service can send cache response by population cache controls in the response.

::: code http_service_cache_response.bal :::

Run the service by executing the following command.

>**Tip:** You may enable the trace logs to observe the in and out traffic.

::: out http_service_cache_response.server.out :::

Invoke the service via the [Caching client](/learn/by-example/http-caching-client).

## Related links
- [`http:ResponseCacheControl` - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/ResponseCacheControl)
- [`http` package - Specification](/spec/http/#53-matrix)
