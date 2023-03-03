# HTTP client - Chunking

The HTTP client can be configured for chunking. By default, the HTTP client sends messages with the `content-length` header. If the message size is larger than the buffer size (8K), messages are chunked. Chunking can be disabled using the client configuration. The chunking behavior can be configured as `CHUNKING_AUTO`, `CHUNKING_ALWAYS`, or `CHUNKING_NEVER` only available HTTP/1.1 protocol. When the config is set to `CHUNKING_ALWAYS`, chunking happens irrespective of the response payload size.

::: code http_client_chunking.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_client_chunking.out :::

## Related links
- [`http1Settings` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ClientHttp1Settings)
- [HTTP client - Specification](https://ballerina.io/spec/http/#24-client)
