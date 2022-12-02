# HTTP client - Header parameter

The http module provides support for sending outbound request headers as resource method arguments. The headers can be provided as `map<string|string[]>` to the resource method. 

::: code http_client_header_parameter.bal :::

## Prerequisites
- Run the HTTP service given in the [REST service - Header parameter](/learn/by-example/http-header-parameter/) example.

Run the client program by executing the following command.

::: out http_client_header_parameter.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client resource methods - Specification](/spec/http/#2423-resource-methods)
