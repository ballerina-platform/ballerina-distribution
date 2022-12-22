# Table types

A `table` is a collection of records in which each record represents a row of the `table`. Each row of the `table` is uniquely identified by a key. This key must be immutable and each row’s key is stored in its fields.
Compared to maps,
- key is part of the value rather than being separate.
- The type of the key is not restricted to string.
- The order of the members is preserved.

::: code table_types.bal :::

::: out table_types.out :::

## Related links
- [Table](https://ballerina.io/learn/by-example/table/)
- [Structured keys](https://ballerina.io/learn/by-example/multiple-key-fields/)
- [Multiple key fields](https://ballerina.io/learn/by-example/multiple-key-fields/)