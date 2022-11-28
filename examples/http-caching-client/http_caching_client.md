# HTTP client - Caching

HTTP caching is enabled by default in HTTP client endpoints. Users can configure caching using the `cache` field in the client configurations.

::: code http_caching_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Sending cache response service](learn/by-example/http-service-cache-response/) example.

Run the client program by executing the following command.

::: out http_caching_client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Caching` - specification](https://ballerina.io/spec/http/#2412-caching)
