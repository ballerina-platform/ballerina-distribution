# Langlib functions

Langlib is a small library defined by language providing fundamental operations on built-in data types.
Langlib functions can be called using convenient method-call syntax, but these types are not objects!
There exists a `ballerina/lang.T` module for each built-in type `T` and they are automatically imported
using `T` prefix.

::: code ./examples/langlib-functions/langlib_functions.bal :::

::: out ./examples/langlib-functions/langlib_functions.out :::