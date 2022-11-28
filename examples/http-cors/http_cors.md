# HTTP service - CORS (Cross-Origin Resource Sharing)

The CORS headers can be applied in both the service-level and the resource-level. Service-level CORS headers apply to all the resources unless there are headers configured at the resource-level. Ballerina CORS supports both simple and pre-flight requests.

::: code http_cors.bal :::

Run the service as follows.

::: out http_cors.server.out :::

Invoke the service by executing the following cURL commands in a new terminal.

::: out http_cors.client.out :::

## Related links
- [`http:CorsConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/CorsConfig)
