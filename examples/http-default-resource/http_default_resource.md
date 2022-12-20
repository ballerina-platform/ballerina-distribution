# HTTP service - Default resource

The default resource slightly varies from the usual resource function as it uses `rest parameters` as the `resource path` and the `default` identifier as the `resource accessor`. The `rest parameters` allow any of the URL paths to be matched, and it supports `string`, `int`, `float`, `boolean`, and `decimal` as types. The `default` identifier also allows any HTTP methods to be dispatched to the resource function. Use it when designing a REST API to handle proxy services or as a default location to get dispatched if none of the other resources are matched.

::: code http_default_resource.bal :::

Run the service as follows.

::: out http_default_resource.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_default_resource.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service default resource - Specification](/spec/http/#233-path-parameter)
