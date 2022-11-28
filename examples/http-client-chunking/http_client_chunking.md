# HTTP client - Chunking

The HTTP client can be configured for chunking. By default, the HTTP client sends messages with the `content-length` header. If the message size is larger than the buffer size (8K), messages are chunked. Chunking can be disabled using the client options.

::: code http_client_chunking.bal :::

## Prerequisites
- Start the [Basic REST service](/learn/by-example/http-basic-rest-service/).

Run the client program by executing the following command.

::: out http_client_chunking.out :::

## Related links
- [`http1Settings` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ClientHttp1Settings)
