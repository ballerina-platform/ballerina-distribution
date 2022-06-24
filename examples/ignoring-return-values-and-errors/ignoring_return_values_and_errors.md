# Ignoring return values and errors

Ballerina does not allow silently ignoring return values.
To ignore a return value, assign it to `_`; this is like 
an implicitly declared variable that cannot be referenced.
When a return type includes an error, you have to do something 
with the error.
`_` is of type any: you cannot use `_` to ignore an error.
`checkpanic` is like `check`, but panics on error rather than 
returning.

::: code ignoring_return_values_and_errors.bal :::

::: out ignoring_return_values_and_errors.out :::