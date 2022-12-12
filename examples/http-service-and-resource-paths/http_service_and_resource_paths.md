# REST service - Service and resource paths

The `service-path` is defined in the service declaration and the `resource-path` is defined in the resource method definition. Each resource can be invoked by using the `service-path`, `resource-path`, and `resource-accessor`. In an HTTP resource, `resource-accessor` confines the resource to a specific HTTP method.

::: code http_service_and_resource_paths.bal :::

Run the service as follows.

::: out http_service_and_resource_paths.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_and_resource_paths.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service path - Specification](/spec/http/#222-service-base-path)
