# HTTP service - HTTP/2 Server push

HTTP/2 server push messages can be sent using the Ballerina `http` service. HTTP/2 server push messages allow the server to send resources to the client before the client requests them.

::: code http_2_0_server_push.bal :::

Run the service by executing the following command.

::: out http_2_0_server_push.out :::

>**Tip:** You can invoke the above service via the [Server push client](/learn/by-example/http-2-0-client-server-push/) example.

## Related links
- [`promise()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Caller#promise)
- [`pushPromisedResponse()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Caller#pushPromisedResponse)
- [HTTP service Server push - Specification](/spec/http/#1011-push-promise-and-promise-response)
