# HTTP client - Circuit breaker

The circuit breaker is used to gracefully handle errors which could occur due to network and backend failures.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) and [specification](https://ballerina.io/spec/http/#2415-circuit-breaker).

::: code http_circuit_breaker.bal :::

Run the program by executing the following command.

>**Info:** As a prerequisite to running the client, start a service.

::: out http_circuit_breaker.out :::
