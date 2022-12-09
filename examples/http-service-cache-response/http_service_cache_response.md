# REST service - Send cache response

HTTP service can send cache response by adding `http:Cache` annotation to the return type.

::: code http_service_cache_response.bal :::

Run the service by executing the following command.

::: out http_service_cache_response.server.out :::

>**Tip:** You can invoke the above service via the [Caching client](/learn/by-example/http-caching-client). In addition to that [trace logs](/learn/by-example/http-trace-logs/) can be enabled to observe the in and out traffic.

## Related links
- [`http:HttpCacheConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/HttpCacheConfig)
- [`http` package - Specification](/spec/http/#53-matrix)
