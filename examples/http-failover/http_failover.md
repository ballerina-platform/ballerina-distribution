# Failover

Ballerina users can configure multiple HTTP clients in a given failover group.  If one of the HTTP clients (dependencies) fails, Ballerina automatically fails over to another endpoint. The following example depicts the `FailoverClient` behaviour with three target services. The first two targets are configured to mimic failure backends. After the first invocation the client resumes the failover from the last successful target. In this case it is the third target and the client will get the immediate response for subsequent calls.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/).
and [specification](https://ballerina.io/spec/http/#2418-failover).

::: code http_failover.bal :::

Run the service as follows.

::: out http_failover.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_failover.client.out :::
