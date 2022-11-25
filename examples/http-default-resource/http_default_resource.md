# HTTP service - Default resource

Ballerina provides rest params in the resource path and the default resource method to help designing proxy services and default resources. It can be used to handle unmatched requests.

::: code http_default_resource.bal :::

Run the service as follows.

::: out http_default_resource.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_default_resource.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Default resource` - specification](https://ballerina.io/spec/http/#233-path-parameter)
