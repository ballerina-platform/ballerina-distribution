# Compression

The HTTP service can be configured to change the compression behaviour. By default, the server compresses the response entity body with the scheme(gzip, deflate) that is specified in the Accept-Encoding request header. When the particular header is not present or the header value is "identity", the server does not perform any compression. Compression is disabled when the option is set to `COMPRESSION_NEVER` and always enabled when the option is set to `COMPRESSION_ALWAYS`

In the same way `http:Client` can be configured as well. For more information on the underlying module, see the [HTTP module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_compression.bal :::

Run the service as follows.

::: out http_compression.server.out :::

Invoke the service by executing the following cURL command in a new terminal.
Here, the `Accept-Encoding` header is not specified.

::: out http_compression.client.out :::
