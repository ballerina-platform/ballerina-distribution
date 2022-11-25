# HTTP client - Failover

Ballerina users can configure multiple HTTP clients in a given failover group.  If one of the HTTP clients (dependencies) fails, Ballerina automatically fails over to another endpoint. The following example depicts the `FailoverClient` behaviour with three target services. The first two targets are configured to mimic failure backends. After the first invocation the client resumes the failover from the last successful target. In this case it is the third target and the client will get the immediate response for subsequent calls.

::: code http_failover.bal :::

Run the program by executing the following command.

>**Info:** As a prerequisite to running the client, start a service.

::: out http_failover.out :::

## Related links
- [`http` - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Failover` - specification](https://ballerina.io/spec/http/#2418-failover)
