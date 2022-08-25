# Built-in string subtype

The `ballerina/lang.string` lang library defines the `Char` type, which is a built-in subtype of `string`. A string belongs to the `string:Char` type if it has a length of 1.

This subtype is analogous to built-in subtypes of `int` and `xml`.

A `string:Char` value can be converted to a code point, which is represented as an `int` value.

::: code built_in_string_subtype.bal :::

::: out built_in_string_subtype.out :::
