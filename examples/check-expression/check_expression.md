# Check

check E is used with an expression E that might result in an error value, including custom errors. If E results in an error value , then, check makes the function return that error value immediately.

The type of check E does not include `error`.
`check E` can be used as a statement where type of `check E`  should be `()`

::: code check_expression.bal :::

::: out check_expression.out :::

## Related Links
- [Errors](https://ballerina.io/learn/by-example/error-reporting/)
- [Error handling](https://ballerina.io/learn/by-example/error-handling/)
- [Panics](https://ballerina.io/learn/by-example/panics/)
- [Checkpanic](https://ballerina.io/learn/by-example/checkpanic/)
- [Error Subtyping](https://ballerina.io/learn/by-example/error-subtyping/)