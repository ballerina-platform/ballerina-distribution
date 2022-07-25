# Chunking

The HTTP client can be configured for chunking. By default, the HTTP client sends messages with the `content-length`
header. If the message size is larger than the buffer size (8K), messages are chunked. Chunking can be disabled using
the client options.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_disable_chunking.bal :::

::: out http_disable_chunking.client.out :::

::: out http_disable_chunking.server.out :::