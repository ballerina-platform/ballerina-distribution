# Circuit breaker

The Circuit Breaker is used to gracefully handle network related errors, which occur when using the HTTP Client. Behavior of this example is something similar to as follows.

1. First two requests works
2. Third request fails and the circuit breaker trips
3. As a result subsequent requests fails immediately until the timeout period is reached
4. Timeout is reached and the circuit breaker falls back to closed state

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/)
and [specification](https://ballerina.io/spec/http/#2415-circuit-breaker).

::: code http_circuit_breaker.bal :::

Run the service as follows.

::: out http_circuit_breaker.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_circuit_breaker.client.out :::
