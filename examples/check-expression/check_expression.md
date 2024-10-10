# Check expression

If an expression can cause an `error`, you can use the `check` expression to indicate you want to terminate the execution of the current scope with that error as the result. Generally this is done by returning the error value from the current function.

::: code check_expression.bal :::

::: out check_expression.out :::

+ [`check` semantics](https://ballerina.io/learn/concurrency/#check-semantics)
