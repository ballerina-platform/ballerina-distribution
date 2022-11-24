# REST service - Service path and resource path

Ballerina supports writing RESTful services according to the JAX-RS specification. You can use the `service-path` and `resource-name` to access a resource function while the `accessor-name`, which is an HTTP verb as `post` and `get` to constrain your resource function in a RESTful manner.

::: code http_service_path_and_resource_path.bal :::

Run the service as follows.

::: out http_service_path_and_resource_path.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_path_and_resource_path.client.out :::

## Related links
- [`http` package API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Service path` - specification](https://ballerina.io/spec/http/#222-service-base-path)
