# Resource method typing

Resource method arguments can use user-defined types.
Listener will use introspection to map from protocol format 
(typically JSON) to user-defined type, using `cloneWithType`.
Return value that is subtype of `anydata` will be mapped from 
user-defined type to protocol format, typically JSON, using `toJson`.
Can generate API description (e.g. OpenAPI) from Ballerina 
service declaration.
Annotations can be used to refine the mapping between 
Ballerina-declared type and wire format.

::: code resource_method_typing.bal :::

::: out resource_method_typing.client.out :::

::: out resource_method_typing.server.out :::