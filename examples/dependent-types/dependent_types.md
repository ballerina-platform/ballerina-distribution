# Dependent types

Ballerina supports a concept called dependent types that makes the return type of a function dependent on the value of a parameter. Unlike the normal convention where the return type is defined independently, here the return type depends on a parameter which is a type descriptor. When the parameter has a default value of `<>` the compiler infers the argument for the parameter from the function call context.

::: code dependent_types.bal :::

::: out dependent_types.out :::
