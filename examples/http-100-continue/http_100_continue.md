# HTTP service - 100 continue

Convenience functions are provided in the `http` module for ease of use when handling `100-continue` scenarios. The `100-continue` indicates that the server has received the request headers and the client can proceed with sending the request. It is done by invoking the `continue` method of the `http:Caller` which results in an interim response containing the `100 Continue` status code if allowed. This is useful when handling multipart or large request payloads.

::: code http_100_continue.bal :::

Run the service as follows.

::: out http_100_continue.server.out :::

Invoke the service by executing the following cURL commands in a new terminal.

::: out http_100_continue.client.out :::

## Related links
- [`expects100Continue()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Request#expects100Continue)
