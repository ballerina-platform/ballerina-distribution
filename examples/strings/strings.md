# Strings

The `string` type represents immutable sequence of zero or more Unicode characters. 
There is no separate character type: a character is represented by a `string` of length 1.
Two `string` values are `==` if both sequences have the same characters.
You can use `<`, `<=`, `>`, and `>=` operators on `string` values and they work by comparing code points.
Unpaired surrogates are not allowed.

::: code strings.bal :::

::: out strings.out :::