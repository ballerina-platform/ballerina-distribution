# HTTP service - Restrict by media type

The content negotiation for the REST API design is achieved via the `consumes` and `produces` configurations. The resource accepting request content type is defined under the `consumes` and the resource producing response content type is defined under the `produces` in the resource configuration. Each configuration is checked against the `Accept` header and the `Content-type` header of the request. If the negotiation fails, the error response is returned with `406 Not Acceptable` or `415 Unsupported` status codes respectively.

::: code http_restrict_by_media_type.bal :::

Run the service as follows.

::: out http_restrict_by_media_type.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_restrict_by_media_type.client.out :::

## Related links
- [`http:ResourceConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest#HttpResourceConfig)
- [HTTP service resource configuration - Specification](/spec/http/#42-resource-configuration)
