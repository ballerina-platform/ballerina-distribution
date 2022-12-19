# Function types
In Ballerina, function type is a separate basic type. The syntax for a function type looks like a function definition without a function name. 

When assigning a function value to a variable of function type, the function signatures must be equal. However, parameters may have default values in either the function value or the function type, or both. If a default value is provided in both the function value and function type, the default value in the function type will be used when the function is invoked.

::: code function_types.bal :::

::: out function_types.out :::

## Related links
- [Function values](/learn/by-example/function-values/)
- [Anonymous function](/learn/by-example/anonymous-function/)
- [Default values for function parameters](/learn/by-example/default-values-for-function-parameters/)
- [Function pointers](/learn/by-example/function-pointers/)
