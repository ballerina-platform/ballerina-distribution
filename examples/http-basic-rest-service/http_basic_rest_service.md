# REST service - Basic

Ballerina supports writing RESTful with its first class service and resource concepts. The `accessor-name`, `service/resource name`, `data binding`, `path` and `query` parameter support helps to write meaningful APIs. The sample depicts the way of writing `GET` and `POST` resources.

::: code http_basic_rest_service.bal :::

Run the service as follows.

::: out http_basic_rest_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_basic_rest_service.client.out :::

## Related links
- [`http` - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Resource` - specification](https://ballerina.io/spec/http/#23-resource)
