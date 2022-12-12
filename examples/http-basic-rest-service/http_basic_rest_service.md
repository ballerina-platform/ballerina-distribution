# REST service - Basic

Ballerina language has first class support for service and resource concepts. The `accessor-name`, `service/resource name`, `data binding`, `path parameter`, and `query parameter` support in the Ballerina `http` module is useful when writing RESTful APIs. Use an `http:Service` with resource methods to implement a REST API service. 

::: code http_basic_rest_service.bal :::

Run the service as follows.

::: out http_basic_rest_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_basic_rest_service.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service resource - Specification](/spec/http/#23-resource)
