# Check semantics

`check` semantics is not to simply return on an `error` value.
When `check` gets an `error` value, it fails.
The enclosing block decides how to handle the failure.
Most blocks pass the failure up to the enclosing block.
Function definition handles the failure by returning the error.
`on fail` can catch the error.
`fail` statement is like `check`, but it always fails.
Differs from exceptions in that control flow is explicit.

::: code check_semantics.bal :::

::: out check_semantics.out :::