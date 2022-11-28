# REST service - Service path and resource name

Ballerina supports writing RESTful services. Each resource method can be invoked via `service-path` and `resource-name`. The `resource accessor` confines the resource to the specified HTTP method.

::: code http_service_path_and_resource_name.bal :::

Run the service as follows.

::: out http_service_path_and_resource_name.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_path_and_resource_name.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Service path` - specification](https://ballerina.io/spec/http/#222-service-base-path)
