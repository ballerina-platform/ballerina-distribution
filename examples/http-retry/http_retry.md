# Retry

The HTTP retry client tries sending over the same request to the backend service when there is a network level failure.

For more information on the underlying module, see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_retry.bal :::

Run the service as follows.

::: out http_retry.server.out :::

Invoke the service by executing the following cURL command in a new terminal.
If the request that was sent to the `retry` resource fails due to an error, the client tries sending the request again.

::: out http_retry.client.out :::
