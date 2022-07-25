# Service path and resource path

Ballerina supports writing RESTful services according to the JAX-RS specification. 
You can use the `absolute-resource-path` and `resource-name` to access a resource function while the `accessor-name`,
which is an HTTP verb as `post` and `get` to constrain your resource function in a RESTful manner.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_absolute_path_and_path.bal :::

::: out http_absolute_path_and_path.client.out :::

::: out http_absolute_path_and_path.server.out :::