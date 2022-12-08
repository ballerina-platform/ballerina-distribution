# REST service - Send cache response

HTTP service can send cache response by adding `http:Cache` annotation to the return type.

::: code http_service_cache_response.bal :::

Run the service by executing the following command.

>**Tip:** You may enable the [trace logs](/learn/by-example/http-trace-logs/) to observe the in and out traffic.

::: out http_service_cache_response.server.out :::

>**Info:** You can invoke the above service via the [Caching client](/learn/by-example/http-caching-client).

## Related links
- [`http:HttpCacheConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/HttpCacheConfig)
- [`http` package - Specification](/spec/http/#53-matrix)
