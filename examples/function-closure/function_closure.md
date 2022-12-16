# Function closure

The object constructor and function can work as a closure, which captures its surrounding environment and can access variables outside of its own scope. This means that a closure can access variables that are defined in a different scope, such as the global scope or the scope of a parent.

It is a compile-time error to have parameter names same as outer-scope variable names.

::: code function_closure.bal :::

::: out function_closure.out :::

## Related links
- [Function values](/learn/by-example/function-values/)
- [Anonymous function](/learn/by-example/anonymous-function/)
