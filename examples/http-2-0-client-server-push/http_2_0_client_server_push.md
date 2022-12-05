# HTTP client - Server push

HTTP/2 server push messages can be received using the Ballerina `http` client. HTTP/2 Server Push messages allow the server to send resources to the client before the client requests for it.

::: code http_2_0_service.bal :::

## Prerequisites
- Run the HTTP service given in the [HTTP/2 server push](/learn/by-example/http-2-0-server-push/) example.

Run the client program by executing the following command.

::: out http_2_0_client_server_push.out :::

## Related links
- [`hasPromise()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Client#hasPromise)
- [`getNextPromise()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Client#getNextPromise)
- [`rejectPromise()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Client#rejectPromise)
- [Push promise and promise response - Specification](/spec/http/#1011-push-promise-and-promise-response)
