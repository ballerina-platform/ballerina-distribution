# REST service - Basic

Ballerina supports writing RESTful with its first class service and resource concepts. The `accessor-name`, `service/resource name`, `data binding`, `path` and `query` parameter support helps to write meaningful APIs. The sample depicts the way of writing `GET` and `POST` resources.

::: code http_basic_rest_service.bal :::

Run the service as follows.

::: out http_basic_rest_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_basic_rest_service.client.out :::

>**Info:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/)

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service resource - Specification](/spec/http/#23-resource)
