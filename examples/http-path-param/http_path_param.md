# REST service - Path parameter

The `path parameter` is a mandatory but variable part of a resource URL. `Path parameters` can be added to a resource method by specifying the parameter type and name in the resource path (eg: `albums/[string name]`). The `http` module supports `string`, `int`, `float`, `boolean`, and `decimal` types as path parameter types. Use it when designing REST API endpoints that require dynamic path segments.

::: code http_path_param.bal :::

Run the service as follows.

::: out http_path_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_path_param.client.out :::

>**Tip:** You can invoke the above service via the client given in the [HTTP client - Path parameter](/learn/by-example/http-client-path-parameter/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service path parameter - Specification](/spec/http/#233-path-parameter)
