# Converting to user-defined type

The `cloneWithType()` langlib function in the `lang.value` module can be used to convert a value to a user-defined type. The result recursively uses the specified type as the inherent type of the new value. It automatically performs numeric conversions as necessary. Every part of the value is cloned including immutable, structural values. The graph structure is not preserved. The `fromJsonWithType()` variant also does the reverse of the conversions done by `toJson()`.

::: code converting_to_user_defined_type.bal :::

::: out converting_to_user_defined_type.out :::