# Casting JSON to user-defined type

In order to access the field in the `json` value, the easiest way is to convert the `json` value to a user-defined type. 
The type-casting can be used to do that. However, if the cast fails, the program panics with an error. The recommended way to do this is by using langlib functions.
Casting to a user-defined type will work on mutable structure only if the inherent type (a structured value has an inherent type, which is a type descriptor that is part of the structured value's runtime value) of that structure is a subtype of the user-defined type.
Casting immutable values will work. However, it does not do numeric conversions.

::: code casting_json_to_user_defined_type.bal :::

::: out casting_json_to_user_defined_type.out :::

## Related links
- [JSON type](/learn/by-example/json-type/)
- [Open records](/learn/by-example/open-records/)
- [Control openness](/learn/by-example/controlling-openness/)
- [Anydata type](/learn/by-example/anydata-type/)
- [Converting JSON with langlib functions](/learn/by-example/converting-json-with-langlib-functions/)
- [Check expression](/learn/by-example/check-expression/)