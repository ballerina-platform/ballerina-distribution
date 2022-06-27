# Binary data

Binary data is represented by arrays of `byte` values. It is a special syntax for `byte` arrays in `base 64` and `base 16`. 

The relationship between `byte` and `int` is not the same as what you are used to. A `byte` is an `int` in the range `0` to `0xFF`. `byte` is a subtype of int. `int` type supports normal bitwise operators: `&` `|` `^` `~` `<<` `>>` `>>>`. Ballerina knows the obvious rules about when bitwise operations produce a `byte`.

::: code binary_data.bal :::

::: out binary_data.out :::