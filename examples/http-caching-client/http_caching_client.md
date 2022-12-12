# HTTP client - Enable Caching

HTTP caching is enabled by default in the `http:Client`. The cache configurations can be set by the `cache` field in the `http:ClientConfiguration`. The default behavior is to allow caching only when the `Cache-Control` header and either the `ETag` or `Last-Modified` headers are present. Use the `policy` field of the `http:CacheConfig` if you want to change this default behavior. The `http` module currently supports the following policies: `http:CACHE_CONTROL_AND_VALIDATORS`(the default policy) and `http:RFC_7234`.

::: code http_caching_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Sending cache response service](learn/by-example/http-service-cache-response/) example.

Run the client program by executing the following command.

::: out http_caching_client.out :::

>**Tip:** You can enable the [trace logs](/learn/by-example/http-trace-logs/) for both service and client to observe the in and out traffic.

## Related links
- [`http:CacheConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/CacheConfig)
- [HTTP client caching - Specification](/spec/http/#2412-caching)
