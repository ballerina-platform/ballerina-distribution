# HTTP client - Retry

The HTTP retry client tries sending over the same request to the backend service when there is a network-level failure. The retry is configured in the `retryConfig` field of the client configuration.

::: code http_retry.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the program by executing the following command.

::: out http_retry.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client retry - Specification](/spec/http/#2414-retry)
