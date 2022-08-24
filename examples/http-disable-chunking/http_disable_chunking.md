# Chunking

The HTTP client can be configured for chunking. By default, the HTTP client sends messages with the `content-length` header. If the message size is larger than the buffer size (8K), messages are chunked. Chunking can be disabled using the client options.

For more information on the underlying module, see the [HTTP module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_disable_chunking.bal :::

Run the service as follows.

::: out http_disable_chunking.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_disable_chunking.client.out :::
