# REST service - Payload data binding

HTTP service payload data binding helps to access the request payload through a resource signature parameter. The payload parameter should be declared with the `@Payload` annotation and the  parameter type can be `anydata`. Binding failures will be responded with a 400 Bad Request response.

::: code http_service_data_binding.bal :::

Run the service as follows.

::: out http_service_data_binding.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_data_binding.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http:Payload` annotation - API documentation](https://lib.ballerina.io/ballerina/http/latest/annotations#Payload)
- [HTTP service payload parameter - Specification](/spec/http/#2344-payload-parameter)
