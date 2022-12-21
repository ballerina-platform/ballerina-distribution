# Querying tables

Query expressions can be used to create a map from an iterable value. Query expression should be preceded by the `map` keyword in this case.

The type of the value in the select clause must belong to the tuple type `[string, T]`, where `map<T>` is the type of the constructed value.

::: code querying_tables.bal :::

::: out querying_tables.out :::

## Related links
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
