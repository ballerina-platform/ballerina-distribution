# REST service - Basic

Ballerina language has first-class abstractions for service and resource concepts in the form of `service` and `resource functions`. A resource function consists of an accessor and path. A service can have a collection of resource functions. These abstractions allow mapping REST concepts such as operations, resource paths and resource representations cleanly into your program. `http:Service` can be used to write RESTful services. A service is defined with a base path, the path common to all resource paths. Each resource function is defined with the required operation such as `get`, `put`, `post`, etc and the path. Similar to regular functions resource functions have input parameters and return types that are mapped to the HTTP request and response.

::: code http_basic_rest_service.bal :::

Run the service as follows.

::: out http_basic_rest_service.server.out :::

Invoke the HTTP GET resource by executing the following cURL command in a new terminal.

::: out http_basic_rest_service.client.1.out :::

Invoke the HTTP POST resource by executing the following cURL command in a new terminal.

::: out http_basic_rest_service.client.2.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service resource - Specification](/spec/http/#23-resource)
