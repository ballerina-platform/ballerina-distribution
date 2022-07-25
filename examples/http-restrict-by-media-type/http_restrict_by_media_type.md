# Restrict by media type

You can configure resources of HTTP services to restrict the types of media they consume and produce.
This is done through the `consumes` and `produces` annotation attributes of the `ResourceConfig` annotation,
which is used with resources.<br/><br/>
For more information on the underlying module,
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_restrict_by_media_type.bal :::

::: out http_restrict_by_media_type.client.out :::

::: out http_restrict_by_media_type.server.out :::