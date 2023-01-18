# Table types

A `table` is a collection of records in which each record represents a row of the `table`. Each row of the `table` is uniquely identified by a key. This key must be immutable and each row’s key is stored in its fields.
Compared to maps,
- the key is part of the value rather than being separate.
- the type of the key is not restricted to string.
- the order of the members is preserved.

::: code table_types.bal :::

::: out table_types.out :::

## Related links
- [Table](/learn/by-example/table/)
- [Structured keys](/learn/by-example/structured-keys/)
- [Multiple key fields](/learn/by-example/multiple-key-fields/)