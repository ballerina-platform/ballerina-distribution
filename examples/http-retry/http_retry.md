# Retry

The HTTP retry client tries sending over the same request to the backend service when there is a network level failure.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-retry/http_retry.bal :::

::: out ./examples/http-retry/http_retry.client.out :::

::: out ./examples/http-retry/http_retry.server.out :::