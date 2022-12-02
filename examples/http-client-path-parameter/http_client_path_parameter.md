# HTTP client - Path parameter

The `http` module provides first class support for specifying `Path parameters` in the resource invocation along with the type. The supported types are string, int, float, boolean, and decimal (e.g., path/[string foo]).

::: code http_client_path_parameter.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Path parameter](/learn/by-example/http-path-param/) example.

Run the client program by executing the following command.

::: out http_client_path_parameter.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
