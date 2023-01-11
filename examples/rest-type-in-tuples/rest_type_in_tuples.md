# Rest type in tuples

A Tuple type descriptor can optionally contain a tuple rest descriptor. It can be described as `[R...]`. This implies that the tuple can contain zero or more members after the `n`th member where the type of those members are `R`. Rest type descriptor should be the last member type descriptor in the tuple. Tuples are not open by default.

::: code rest_type_in_tuples.bal :::

::: out rest_type_in_tuples.out :::

## Related links
- [Tuples](/learn/by-example/tuples)
- [Arrays](/learn/by-example/arrays)
- [Manipulating an array `(lang.array)`](https://lib.ballerina.io/ballerina/lang.array)
- [Filler values of a list](/learn/by-example/filler-values-of-a-list)
- [List sub typing](/learn/by-example/list-subtyping)
- [List equality](/learn/by-example/list-equality)