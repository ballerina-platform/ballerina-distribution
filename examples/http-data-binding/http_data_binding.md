# Service data binding

HTTP service data binding helps to access the request payload through a resource signature parameter. The payload
parameter should be declared with the `@Payload` annotation and the  parameter type can be `anydata`.
Binding failures will be responded with 400[Bad Request] response<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_data_binding.bal :::

::: out http_data_binding.client.out :::

::: out http_data_binding.server.out :::