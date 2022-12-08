# REST service - Header parameter

The inbound request headers can be accessed as a resource method argument using the `@http:Header` annotation. The header name is resolved by the variable name unless the header name is specified in the `name` field of the annotation. 

The header parameter can be optional and support the basic types such as `string`, `int`, `float`, `decimal`, and `boolean`, and the `array` types of these basic types. The `array` type returns all the values for a given header name, while the basic type returns only the first value. In addition to these types, a `record` type with the basic typed fields can be used to obtain the values of a set of headers specified by the record field names.

Unless the type is optional, the request will be responded with a 400 Bad Request in the absence of the mentioned header. However, more header manipulations can be done via the `http:Headers` header object, which can also be accessed as a resource method argument without using the annotation.

::: code http_header_param.bal :::

Run the service as follows.

::: out http_header_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_header_param.client.out :::

>**Info:** You can invoke the above service via the client in the [HTTP client - Header parameter](/learn/by-example/http-client-header-parameter/) example.

## Related links
- [`Headers` object - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Headers)
- [HTTP service header parameter - Specification](/spec/http/#2345-header-parameter)
