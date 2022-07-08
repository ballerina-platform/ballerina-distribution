# Failover

Ballerina users can configure multiple HTTP clients in a given failover group. 
If one of the HTTP clients (dependencies) fails, Ballerina automatically fails over to another endpoint.
The following example depicts the `FailoverClient` behaviour with three target services. The first two targets
are configured to mimic failure backends.
After the first invocation the client resumes the failover from the last successful target. In this case it is
the third target and the client will get the immediate response for subsequent calls.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_failover.bal :::

::: out http_failover.client.out :::

::: out http_failover.server.out :::