# HTTP client - Server-Sent Events

The `http:Client` in Ballerina supports receiving real-time data from services using Server-Sent Events (SSE). It allows payload-binding of a stream of `http:SseEvent` when consuming SSE from a service. This payload binding fails if the content type header is not present in the response or does not have the value `text/event-stream`.

::: code http_sse_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Server-Sent Events](/learn/by-example/http-sse-service/) example.

Run the client program by executing the command below.

::: out http_sse_client.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [Client action return types - Specification](/spec/http/#243-client-action-return-types)
