# REST service - Header parameter

The `http` resource method allows you to access the inbound request header value as a resource argument. The header value can be either accessed as a single value or, an array of values.
This can be achieved by adding the `@http:Header` annotation to the resource argument. The header name is resolved by the variable name unless the header name is specified in the `name` field of the annotation. The header parameter can be optional and support the basic types such as `string`, `int`, `float`, `decimal`, and `boolean`, and the `array` types of these basic types. Unless the type is optional, the request will be responded with a 400 Bad Request in the absence of the mentioned header.
Use this annotated argument in the resource method to obtain the header value/values of a given header. 
Furthermore, the values of a set of headers can be retrieved using a `record` type annotated with `@http:Header`. Here, the header names are resolved by the record field names. In addition, more header manipulations can be done via the `http:Headers` header object, which can also be accessed as a resource method argument without using the annotation.

::: code http_header_param.bal :::

Run the service as follows.

::: out http_header_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_header_param.client.out :::

>**Info:** You can invoke the above service via the client in the [HTTP client - Header parameter](/learn/by-example/http-client-header-parameter/) example.

## Related links
- [`Headers` object - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Headers)
- [HTTP service header parameter - Specification](/spec/http/#2345-header-parameter)
