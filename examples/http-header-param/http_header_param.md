# REST service - Header parameter

The `@http:header` annotation allows reading header values from the request. The annotation can be used to annotate a given resource parameter. The name of the parameter must match the name of the header. If there is a mismatch, then the header name must be given in the annotation configuration. The resource parameter can be a simple type or an array type (i.e., `string version` or `string[] versions`). If there are many headers to read, a record type can be used as the parameter. Unless the parameter is optional (i.e., `string? version`), a `400 Bad Request` response is sent to the client in the absence of the mapping header.

::: code http_header_param.bal :::

Run the service as follows.

::: out http_header_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_header_param.client.out :::

>**Tip:** You can invoke the above service via the client given in the [HTTP client - Header parameter](/learn/by-example/http-client-header-parameter/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service header parameter - Specification](/spec/http/#2345-header-parameter)
