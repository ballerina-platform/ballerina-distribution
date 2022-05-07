# Service path and resource path

Ballerina supports writing RESTful services according to the JAX-RS specification. 
You can use the `absolute-resource-path` and `resource-name` to access a resource function while the `accessor-name`,
which is an HTTP verb as `post` and `get` to constrain your resource function in a RESTful manner.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-absolute-path-and-path/http_absolute_path_and_path.bal :::

::: out ./examples/http-absolute-path-and-path/http_absolute_path_and_path.client.out :::

::: out ./examples/http-absolute-path-and-path/http_absolute_path_and_path.server.out :::