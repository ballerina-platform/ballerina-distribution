# Converting to user-defined type

The `cloneWithType()` langlib function in the lang.value
module can be used to convert a value to a user-defined type.
Result recursively uses specified type as inherent type of new value.
Automatically performs numeric conversions as necessary.
Every part of the value is cloned including immutable structural values.
Graph structure is not preserved. 
Variant `fromJsonWithType()` also does reverse of conversions done by
`toJson`.

::: code converting_to_user_defined_type.bal :::

::: out converting_to_user_defined_type.out :::