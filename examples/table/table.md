# Table

The table constructor expression looks like an array constructor. `add` and `put` langlib functions can be used to update a table. `put` method will update the table if there already is an entry with a given key or add a new entry otherwise, while the `add` method will panic if there's already an entry with the given key. The `foreach` statement will iterate over a table's rows in their order. Use `t[k]` to access a row using its key.

::: code table.bal :::

::: out table.out :::

## Related links
- [Maps](https://ballerina.io/learn/by-example/maps/)
- [Structured keys](https://ballerina.io/learn/by-example/multiple-key-fields/)
- [Multiple key fields](https://ballerina.io/learn/by-example/multiple-key-fields/)
- [Control openness](https://ballerina.io/learn/by-example/controlling-openness/)