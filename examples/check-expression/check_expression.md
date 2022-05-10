# Check expression

`check E` is used with an expression `E` that might result in an `error` value.
If `E` results in an `error` value , then `check` makes the function return that `error` value
immediately.
Type of `check E` does not include `error`.
The control flow remains explicit.

::: code ./examples/check-expression/check_expression.bal :::

::: out ./examples/check-expression/check_expression.out :::