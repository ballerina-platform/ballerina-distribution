# REST service - Service and resource paths

Ballerina supports writing RESTful services. Each resource method can be invoked via `service-path` and `resource-path`. The `resource accessor` confines the resource to the specified HTTP method.

::: code http_service_and_resource_paths.bal :::

Run the service as follows.

::: out http_service_and_resource_paths.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_and_resource_paths.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service path - Specification](/spec/http/#222-service-base-path)
