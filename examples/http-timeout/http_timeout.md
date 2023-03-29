# HTTP client - Timeout

The `timeout` field is used to gracefully handle response delays that could occur due to network problems or the back-end. The client timeout is configured in the `timeout` field of the client configuration in seconds.

::: code http_timeout.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the program by executing the following command.

::: out http_timeout.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http` module - Specification](https://ballerina.io/spec/http/)