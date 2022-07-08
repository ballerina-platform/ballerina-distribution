# Circuit breaker

The Circuit Breaker is used to gracefully handle network related errors, which occur when using the HTTP Client. Behavior of this example is something similar to as follows,
1) First two requests works, 2) Third request fails and the circuit breaker trips, 3) As a result subsequent requests fails immediately until the timeout period is reached,
4) Timeout is reached and the circuit breaker falls back to closed state. <br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_circuit_breaker.bal :::

::: out http_circuit_breaker.client.out :::

::: out http_circuit_breaker.server.out :::