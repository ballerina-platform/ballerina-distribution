# Check expression

In Ballerina, it is common to write an expression that may result in an error, such as calling a function that could return an error value, checking if the result belongs to the `error` type and immediately returning that value. You can use the `check` expression to simplify this pattern.

::: code check_expression.bal :::

::: out check_expression.out :::
