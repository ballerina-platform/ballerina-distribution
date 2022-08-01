# Path parameter

The `http` module provides first-class support for specifying `Path parameters` in the resource path along with the type.
The supported types are string, int, float, boolean, and decimal (e.g., `path/[string foo]`).

For more information on the underlying module, see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_path_param.bal :::

Run the service as follows.

::: out http_path_param.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_path_param.client.out :::
