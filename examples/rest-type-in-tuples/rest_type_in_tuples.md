# Rest type in tuples

Similar to how maps can be described as record types, arrays can also be defined as tuple types using `...`. The `rest` type in tuples can be described as `[T...]`, which is a tuple containing zero or more members of type `T`. Tuples are not open by default. A tuple type descriptor may or may not contain a rest descriptor but if present, it should be the last member type descriptor in the tuple.

::: code rest_type_in_tuples.bal :::

::: out rest_type_in_tuples.out :::