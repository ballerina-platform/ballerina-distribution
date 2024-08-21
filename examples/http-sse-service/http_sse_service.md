# HTTP service - Server-sent events

Ballerina HTTP services support pushing real-time data to clients using server-sent events (SSE). A stream of type `http:SseEvent` can be returned from service resource methods. This feature automatically handles sending SSE and sets the content type to `text/event-stream` and the transfer encoding to chunked.

::: code http_sse_service.bal :::

Run the service program by executing the following command.

::: out http_sse_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_sse_service.client.out :::

>**Tip:** You can invoke the above service via the [Client server-sent events](/learn/by-example/http-sse-client/) example.

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [Resource return types - Specification](/spec/http/#235-return-types)
