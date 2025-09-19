# Trap expression

If you have an expression such as a function call that can potentially trigger a panic you can use a `trap` expression to prevent further unwinding of the stack. Then if the evaluation of the expression triggers a panic you will get the `error` value associated with the panic. Otherwise, you will get the result of the expression.

::: code trap_expression.bal :::

::: out trap_expression.out :::

+ [Panics](https://ballerina.io/learn/by-example/panics/)
