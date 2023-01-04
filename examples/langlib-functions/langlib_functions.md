# Langlib functions

Langlib is a library defined by language providing fundamental operations on built-in data types. Langlib functions can be called using convenient method-call syntax, but these types are not objects.

There exists a `ballerina/lang.T` module for each built-in type `T` and they are automatically imported using `T` prefix only if `T` corresponds to a keyword.

The `lang.value` module provides functions that work on values of more than one basic type.

::: code langlib_functions.bal :::

::: out langlib_functions.out :::
