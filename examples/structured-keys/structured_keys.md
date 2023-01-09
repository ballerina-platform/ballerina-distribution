# Structured keys

Key fields can be structured types as long as they belong to any subtype of plain data. Plain data is a simple value, a sequence value, or a structured value where all members are plain data. The value of the key field must be immutable. The initializer of the read-only field will be constructed as immutable. When using `add`/`put`, `cloneReadOnly()` can be used to create an immutable value.

## Related links
- [Table syntax](/learn/by-example/table-syntax/)
- [Multiple key fields](/learn/by-example/multiple-key-fields/)
- [Records](/learn/by-example/records/)

::: code structured_keys.bal :::

::: out structured_keys.out :::