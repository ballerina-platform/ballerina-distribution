# REST service - Payload data binding

HTTP service payload data binding allows accessing the request payload using a resource signature parameter. The resource parameter which is bound to the request payload should be annotated with `@http:Payload` annotation. The resource parameter type should be `anydata`. If the data binding fails, a `400 Bad Request` response is sent to the client. Use this to access the request payload directly from the resource.

::: code http_service_data_binding.bal :::

Run the service as follows.

::: out http_service_data_binding.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_data_binding.client.out :::

## Related links
- [`@http:Payload` annotation - API documentation](https://lib.ballerina.io/ballerina/http/latest/annotations#Payload)
- [HTTP service payload parameter - Specification](/spec/http/#2344-payload-parameter)
