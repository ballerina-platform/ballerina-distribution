# Function closure

The object constructor and function can work as a closure, which captures its surrounding environment and can access variables outside of its own scope. This means that a closure can access variables that are defined in its parent scopes.

It is a compile-time error to have parameter names similar to the outer-scope variable names.

::: code function_closure.bal :::

::: out function_closure.out :::

## Related links
- [Function values](/learn/by-example/function-values/)
- [Anonymous function](/learn/by-example/anonymous-function/)
