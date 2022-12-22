# Casting JSON to user-defined type

In order to access the field in the `json` value, the easiest way is to convert the `json` value to a user-defined type. 
The type-casting can be used to do that. But if cast fails, program panic with an error. However the recommended way to do this is by using langlib functions.
Cast to user defined type will work on mutable structure only if the inherent type(A structured value has an inherent type, which is a type descriptor which is part of the structured value's runtime value.) of that structure is a subtype of user defined type.
Casting immutable values will work but it does not do numeric conversions.

::: code casting_json_to_user_defined_type.bal :::

::: out casting_json_to_user_defined_type.out :::

## Related links
- [JSON type](https://ballerina.io/learn/by-example/json-type/)
- [Open records](https://ballerina.io/learn/by-example/open-records/)
- [Control openness](https://ballerina.io/learn/by-example/controlling-openness/)
- [Anydata type](https://ballerina.io/learn/by-example/anydata-type/)
- [Converting JSON with langlib functions](https://ballerina.io/learn/by-example/converting-json-with-langlib-functions/)
- [Check expression](https://ballerina.io/learn/by-example/check-expression/)