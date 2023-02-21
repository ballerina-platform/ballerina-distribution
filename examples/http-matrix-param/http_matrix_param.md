# HTTP service - Matrix parameter

The matrix parameter enhances the hierarchical structure of HTTP URIs. The `http:Request` has the `getMatrixParams` method to extract the matrix parameter map from the given path segment.

::: code http_matrix_param.bal :::

Run the service as follows.

::: out http_matrix_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_matrix_param.client.out :::

## Related links
- [`getMatrixParams()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Request#getMatrixParams)
- [HTTP service matrix parameter - Specification](https://ballerina.io/spec/http/#53-matrix)
