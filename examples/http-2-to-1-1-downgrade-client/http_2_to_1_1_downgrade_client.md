# HTTP client - HTTP/2 to HTTP/1.1 downgrade

The HTTP client is configured to run over the HTTP/1.1 protocol. This client only sends requests over the HTTP/1.1 protocol. When you send a request to an HTTP2 supported service using this client, the connection gets downgraded to HTTP/1.1. If the client is configured to communicate over HTTPS, the ALPN negotiation of choosing which protocol to be used over the secure connection is handled internally. This avoids additional round trips and is independent of the application-layer protocols.  

::: code http_2_to_1_1_downgrade_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_2_to_1_1_downgrade_client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [http client - Specification](https://ballerina.io/spec/http/#24-client)
