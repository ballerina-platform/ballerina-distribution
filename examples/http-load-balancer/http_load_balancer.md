# HTTP client - Load balancer

An HTTP load balancing endpoint is used when the request load needs to be load balanced across a given  set of target endpoints.

::: code http_load_balancer.bal :::

## Prerequisites
- Run multiple instances of the HTTP service given in [Basic REST services](/learn/by-example/http-basic-rest-service/) example by changing the ports accordingly.

Run the program by executing the following command.

::: out http_load_balancer.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service load balance - Specification](/spec/http/#2417-load-balance)
