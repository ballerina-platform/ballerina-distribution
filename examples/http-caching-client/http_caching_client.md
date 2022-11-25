# HTTP client - Caching

HTTP caching is enabled by default in HTTP client endpoints. Users can configure caching using the `cache` field in the client configurations.

::: code http_caching_client.bal :::

Run the client program by executing the following command.

>**Info:** As a prerequisite to running the client, start the [Sending cache response](learn/by-example/http-service-cache-response/) example.

::: out http_caching_client.out :::

## Related links
- [`http` - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Caching` - specification](https://ballerina.io/spec/http/#2412-caching)
