# REST service - Send cache response

The `http:Service` can cache a response associated with a request and reuse the cached response for subsequent requests. This can be achieved by adding the `http:Cache` annotation to the return type. By default, this annotation adds the `must-revalidate`, `public`, and `max-age=3600` directives to the `Cache-Control` header of the response, along with the `ETag` and `Last-Modified` headers. These default settings can be changed by adding the configurations to the annotation. Furthermore, the response is only cached when the return type is `anydata` or a subtype of `http:SuccessStatusCodeResponse`.

::: code http_service_cache_response.bal :::

Run the service by executing the following command.

::: out http_service_cache_response.server.out :::

>**Tip:** You can invoke the above service via the [Caching client](/learn/by-example/http-caching-client) example. In addition to that the [trace logs](/learn/by-example/http-trace-logs/) can be enabled to observe the in and out traffic.

## Related links
- [`http:HttpCacheConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest#HttpCacheConfig)
- [`http:Cache` annotation - Specification](/spec/http/#46-cache-annotation)
