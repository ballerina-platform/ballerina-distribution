# HTTP service - Server-sent events

The `http:Service` in Ballerina supports pushing real-time data to clients using Server-Sent Events (SSE). A stream of `http:SseEvent` can be returned from service resource methods. This feature automatically handles sending SSE and sets the content type to `text/event-stream`, and the transfer encoding is automatically set to chunked.

::: code http_sse_service.bal :::

Run the service program by executing the following command.

::: out http_sse_service.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_sse_service.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [Resource return types - Specification](/spec/http/#235-return-types)
