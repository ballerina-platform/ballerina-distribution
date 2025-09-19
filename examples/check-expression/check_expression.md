# Check expression

If an expression can evaluate to an error value, you can use the `check` expression to indicate that you want the execution of the current block to terminate with that error as the result. This results in the error value being returned from the current function/worker, unless the `check` expression is used in a failure-handling statement (e.g., statement with on fail, retry statement).

::: code check_expression.bal :::

::: out check_expression.out :::

+ [`check` semantics](https://ballerina.io/learn/concurrency/#check-semantics)
