# Caching client

HTTP caching is enabled by default in HTTP client endpoints. Users can configure caching using the `cache` field in the client configurations.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [specification](https://ballerina.io/spec/http/#2412-caching).

::: code http_caching_client.bal :::

Run the service by executing the following command.

(The two services have to be run separately to observe the following output.
For clarity, only the relevant parts of the HTTP trace logs have been included here.)

::: out http_caching_client.server.out :::

Invoke the service as follows.

::: out http_caching_client.client.out :::
