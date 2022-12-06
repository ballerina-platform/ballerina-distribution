# REST service - Header parameter

The `http` module provides support for accessing inbound request headers as resource method arguments. The header key can be specified as a variable name along with the `@http:Header` annotation. Else, it can be specified in the `name` field of the annotation. The supported types are `string`, `string[]`, and optional. The `string[]` type returns all the values for a given header key, while the `string` returns the first value. Unless the type is optional, the request will be responded with a 400 Bad request in the absence of the mentioned header. However, more header manipulations can be done via the `http:Headers` header object, which also can be accessed as a resource method argument without using the annotation.

::: code http_header_param.bal :::

Run the service as follows.

::: out http_header_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_header_param.client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service header parameter - Specification](/spec/http/#2345-header-parameter)
