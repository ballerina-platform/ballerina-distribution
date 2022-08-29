# Service path and resource path

Ballerina supports writing RESTful services according to the JAX-RS specification. You can use the `absolute-resource-path` and `resource-name` to access a resource function while the `accessor-name`, which is an HTTP verb as `post` and `get` to constrain your resource function in a RESTful manner.

For more information on the underlying module, see the [HTTP module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_absolute_path_and_path.bal :::

Run the service as follows.

::: out http_absolute_path_and_path.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_absolute_path_and_path.client.out :::
