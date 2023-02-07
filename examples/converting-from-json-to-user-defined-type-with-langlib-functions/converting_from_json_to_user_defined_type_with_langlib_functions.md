# Convert from JSON to user-defined type with langlib functions

The `cloneWithType()` langlib function can be used to convert a value to a user-defined type. Result recursively uses specified type as inherent type of new value. Automatically performs numeric conversions as necessary.

Every part of the value is cloned including immutable structural values. Also `fromJsonWithType()` langlib function can be used for the same purpose and it also does the reverse of conversions done by toJson.

::: code converting_from_json_to_user_defined_type_with_langlib_functions.bal :::

::: out converting_from_json_to_user_defined_type_with_langlib_functions.out :::

## Related links
- [JSON type](/learn/by-example/json-type/)
- [Open records](/learn/by-example/open-records/)
- [Controlling openess](/learn/by-example/controlling-openness)
- [Check](/learn/by-example/check)
- [Casting JSON to user-defined type](/learn/by-example/casting-json-to-user-defined-type)
