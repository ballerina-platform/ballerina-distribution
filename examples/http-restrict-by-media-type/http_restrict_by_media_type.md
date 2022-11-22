# HTTP service - Restrict by media type

You can configure resources of HTTP services to restrict the types of media they consume and produce. This is done through the `consumes` and `produces` annotation attributes of the `ResourceConfig` annotation, which is used with resources.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) and [specification](https://ballerina.io/spec/http/#42-resource-configuration).

::: code http_restrict_by_media_type.bal :::

Run the service as follows.

::: out http_restrict_by_media_type.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_restrict_by_media_type.client.out :::
