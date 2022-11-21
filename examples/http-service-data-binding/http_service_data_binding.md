# REST service - Payload data binding

HTTP service payload data binding helps to access the request payload through a resource signature parameter. The payload parameter should be declared with the `@Payload` annotation and the  parameter type can be `anydata`. Binding failures will be responded with 400 Bad Request response.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) and [specification](https://ballerina.io/spec/http/#2344-payload-parameter).

::: code http_data_binding.bal :::

Run the service as follows.

::: out http_data_binding.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_data_binding.client.out :::
