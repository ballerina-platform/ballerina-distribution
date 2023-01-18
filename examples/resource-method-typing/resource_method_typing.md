# Resource method typing

Resource method arguments can use user-defined types. The listener will use introspection to map the protocol format (typically JSON) to a user-defined type using `cloneWithType`. The return value, which is a subtype of anydata will be mapped from the user-defined type to the protocol format typically JSON, using `toJson`.

The API description (e.g. OpenAPI) can be generated from the Ballerina service declaration. Annotations can be used to refine the mapping between the Ballerina-declared type and wire format.

## Related links
- [Casting JSON to user-defined type](/learn/by-example/casting-json-to-user-defined-type/)
- [JSON type](/learn/by-example/json-type/)
- [Service data binding](/learn/by-example/http-data-binding/)
- [http module](https://lib.ballerina.io/ballerina/http)

::: code resource_method_typing.bal :::

Run the service using the `bal run` command.

::: out resource_method_typing.server.out :::

Run this cURL command to invoke the resource.

::: out resource_method_typing.client.out :::
