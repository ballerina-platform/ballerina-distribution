# HTTP client - Circuit breaker

The circuit breaker is used to gracefully handle errors which could occur due to network and backend failures.

::: code http_circuit_breaker.bal :::

## Prerequisites
- Start the [Basic REST service](/learn/by-example/http-basic-rest-service/).

 Run the program by executing the following command.

::: out http_circuit_breaker.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Circuit breaker` - specification](https://ballerina.io/spec/http/#2415-circuit-breaker)
