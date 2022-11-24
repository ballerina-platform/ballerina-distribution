# HTTP service - Chunking

The HTTP service can be configured for chunked responses. By default, the HTTP service sends messages with the `content-length` header. If the message size is larger than the buffer size (8K), messages are chunked. Chunking can be disabled using the `@http:ServiceConfig`. The chunking behavior can be configured as `CHUNKING_AUTO`, `CHUNKING_ALWAYS`, or `CHUNKING_NEVER` only available HTTP/1.1 protocol. In this example, it is set to `CHUNKING_ALWAYS`, which means that chunking happens irrespective of the response payload size.

::: code http_service_chunking.bal :::

Run the service as follows.

::: out http_service_chunking.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_service_chunking.client.out :::

## Related links
- [`http` package API documentation](https://lib.ballerina.io/ballerina/http/latest/)
