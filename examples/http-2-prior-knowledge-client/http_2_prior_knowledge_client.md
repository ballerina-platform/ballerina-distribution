# HTTP client - HTTP/2 prior knowledge

The HTTP client is configured to enable HTTP/2 prior knowledge. So the client will directly send requests using HTTP/2 without an HTTP/2 upgrade request.

::: code http_2_prior_knowledge_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the client program by executing the following command.

::: out http_2_prior_knowledge_client.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [http client - Specification](https://ballerina.io/spec/http/#24-client)
