# REST service - Payload data binding

HTTP service payload data binding allows accessing the request payload using a resource signature parameter. The resource parameter type should be of `anydata` subtype. By default parameters with type `map `, `array`, `tuple`, `table`, `record` and `xml` are mapped to the payload. For other types, the `@http:Payload` annotation is required and If the signature includes more than one of the aforementioned types, the `@http:Payload` should be used to resolve the ambiguity. This behaviour is limited to `POST`, `PUT`, `PATCH`, `DELETE`, and `DEFAULT` accessors.  If the data binding process fails, the client receives a 400 Bad Request response. This feature allows direct access to the request payload from the resource.

::: code http_service_data_binding.bal :::

Run the service as follows.

::: out http_service_data_binding.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_data_binding.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`@http:Payload` annotation - API documentation](https://lib.ballerina.io/ballerina/http/latest/annotations#Payload)
- [HTTP service payload parameter - Specification](/spec/http/#2344-payload-parameter)
