# Check semantics

`check` semantics does not simply return an `error` value.
When `check` gets an `error` value, it fails. The enclosing block decides how to handle the failure.
Most blocks pass the failure up to the enclosing block. The function definition handles the failure by returning the error.
`on fail` can catch the error.

The `fail` statement is like `check`, but it always fails. It differs from the exceptions in that the control flow, which are explicit.

::: code check_semantics.bal :::

::: out check_semantics.out :::