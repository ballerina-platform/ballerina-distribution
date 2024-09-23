# WebSocket service - Query parameter

The parameter in the `get` resource method represents the query segment of the request URL. The parameter name should match the query key, and its value is mapped at runtime by extracting it from the URL. Supported types for query parameters include `string`, `int`, `float`, `boolean`, and `decimal`. Query parameter types can be nilable (e.g., `string? bar`). When a request contains query segments, retrieving them as resource arguments is simpler and highly recommended. Alternatively, the `http:Request` object can be used as the parameter of the `get` resource method, which also exposes methods to retrieve query parameters as well.

::: code websocket_query_parameter.bal :::

Run the service as follows.

::: out websocket_query_parameter.server.out :::

>**Tip:** You can invoke the above service via the [WebSocket client](/learn/by-example/websocket-client/).


## Related links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket service - Specification](/spec/websocket/#31-upgrade-service)