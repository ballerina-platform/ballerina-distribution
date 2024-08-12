# HTTP client - Server-sent events

The `http:Client` in Ballerina supports receiving real-time data from services using Server-sent events (SSE). It allows payload-binding of a stream of `http:SseEvent` when consuming SSE from a service. This payload binding fails if the content type header is not present in the response or does not have the value `text/event-stream`.

::: code http_sse_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Server-sent events](/learn/by-example/http-sse-service/) example.

Run the client program by executing the following command.

::: out http_sse_client.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [Client action return types - Specification](/spec/http/#243-client-action-return-types)
