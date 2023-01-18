# Table

The table constructor expression looks like an array constructor. The `add` and `put` langlib functions can be used to update a table. The `put` method will update the table if there is an entry with a given key or add a new entry otherwise, while the `add` method will panic if there is an entry with the given key. The `foreach` statement will iterate over a table's rows in their order. Use `t[k]` to access a row using its key.

::: code table.bal :::

::: out table.out :::

## Related links
- [Maps](/learn/by-example/maps/)
- [Structured keys](/learn/by-example/structured-keys/)
- [Multiple key fields](/learn/by-example/multiple-key-fields/)
- [Control openness](/learn/by-example/controlling-openness/)