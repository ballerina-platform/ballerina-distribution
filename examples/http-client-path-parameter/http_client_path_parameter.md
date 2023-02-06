# HTTP client - Path parameter

The `http:Client` supports specifying `path parameters` when invoking a backend resource. Declare the required `path parameter` inside a square bracket along with the resource path (eg: `/albums/[album]`) and invoke the resource method. Use this when invoking backend resources with variable resource paths.

::: code http_client_path_parameter.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Path parameter](/learn/by-example/http-path-param/) example.

Run the client program by executing the following command.

::: out http_client_path_parameter.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
