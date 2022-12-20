# Resource method typing

Resource method arguments can use user-defined types. Listener will use introspection to map from protocol format (typically JSON) to user-defined type, using cloneWithType. Return value that is a subtype of anydata will be mapped from user-defined type to protocol format, typically JSON, using toJson.

Can generate API description (e.g. OpenAPI) from Ballerina service declaration. Annotations can be used to refine the mapping between Ballerina-declared type and wire format.

## Related links
- [Converting from JSON to user-defined type](https://ballerina.io/learn/by-example/converting-from-json-to-user-defined-type/)
- [JSON type](https://ballerina.io/learn/by-example/json-type/)
- [Service data binding](https://ballerina.io/learn/by-example/http-data-binding/)
- [http module](https://lib.ballerina.io/ballerina/http)

::: code resource_method_typing.bal :::

Run the service using the `bal run` command.

::: out resource_method_typing.server.out :::

Run this cURL command to invoke the resource.

::: out resource_method_typing.client.out :::
