# HTTP client - Failover

A failover client is used to preserve the continuity of the requests flow even if the endpoint fails. The endpoints are defined in the `targets` field of the failover client configuration. If one of the endpoints fails, the client automatically fails over to another endpoint.

::: code http_failover.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the program by executing the following command.

::: out http_failover.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client failover - Specification](/spec/http/#2418-failover)
