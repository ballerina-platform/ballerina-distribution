# Converting JSON with langlib functions 

The `cloneWithType()` langlib function can be used to convert a value to a user-defined type. The result recursively uses the specified type as the inherent type of the new value. This automatically performs the numeric conversions as necessary.

Every part of the value is cloned including the immutable structural values. Also, the `fromJsonWithType()` langlib function can be used for the same purpose and it also does the reverse of the conversions done by `toJson`.

## Related links
- [JSON type](/learn/by-example/json-type/)
- [Open records](/learn/by-example/open-records/)
- [Control openness](/learn/distinctive-language-features/data/#control-openness)
- [Converting from JSON to user defined type](/learn/by-example/converting-from-json-to-user-defined-type/)
- [Check](/learn/by-example/check-expression/)

::: code converting_to_user_defined_type.bal :::

::: out converting_to_user_defined_type.out :::