# HTTP service - CORS (Cross-Origin Resource Sharing)

Cross-Origin Resource Sharing (CORS) is an HTTP-header-based mechanism that allows a server to indicate any origins other than its own from which a browser should permit. The CORS headers can be applied at both the service level and the resource level. Each configuration has the `cors` field to specify the CORS config. Service-level CORS headers apply to all the resources unless there are headers configured at the resource level. Ballerina CORS supports both simple and pre-flight requests.

::: code http_cors.bal :::

Run the service as follows.

::: out http_cors.server.out :::

Invoke the service by executing the following cURL commands in a new terminal.

::: out http_cors.client.out :::

## Related links
- [`http:CorsConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/CorsConfig)
- [HTTP service configuration - Specification](/spec/http/#41-service-configuration);