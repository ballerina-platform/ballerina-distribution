# HTTP client - Circuit breaker

The circuit breaker is used to gracefully handle errors that could occur due to network and backend failures. This is configured in the `circuitBreaker` field of the client configuration. The circuit breaker looks for errors across a rolling time window. After the circuit is broken, it does not send requests to the backend until the `resetTime`.

::: code http_circuit_breaker.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the program by executing the following command.

::: out http_circuit_breaker.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client circuit breaker - Specification](/spec/http/#2415-circuit-breaker)
