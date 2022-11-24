# HTTP service - Server push

HTTP/2 server push messages can be sent and received using the Ballerina `http` library. HTTP/2 Server Push messages allow the server to send resources to the client before the client requests for it.

::: code http_2_0_service.bal :::

Run the service by executing the following command.

::: out http_2_0_service.out :::

::: code http_client.bal :::

Run the client program by executing the following command.

::: out http_client.out :::

## Related links
- [`promise()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Caller#promise)
- [`pushPromisedResponse()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Caller#pushPromisedResponse)
- [`Server push` - specification](https://ballerina.io/spec/http/#1011-push-promise-and-promise-response)
