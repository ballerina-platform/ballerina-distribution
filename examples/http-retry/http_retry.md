# HTTP client - Retry

The HTTP retry client tries sending over the same request to the backend service when there is a network level failure.

::: code http_retry.bal :::

## Prerequisites
- Start the [Basic REST service](/learn/by-example/http-basic-rest-service/).

Run the program by executing the following command.

::: out http_retry.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Retry` - specification](https://ballerina.io/spec/http/#2414-retry)
