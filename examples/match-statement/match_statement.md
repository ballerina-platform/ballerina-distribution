# Match statement

`match` statement is similar to `switch` statement in some other languages. It matches the value, not the type. `==` is used to test whether the left hand side matches the value being matched. The left hand side can be a simple literal (`nil`, `boolean`, `int`, `float`, `string`) identifier referring to a constant.

Left hand side of `_` matches if the value is of type `any`. You can use `|` to match more than one value.

::: code match_statement.bal :::

::: out match_statement.out :::

## Related links
- [If statement](/learn/by-example/if-statement/)
