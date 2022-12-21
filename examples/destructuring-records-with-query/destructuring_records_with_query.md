# Destructuring records

Destructuring records is particularly useful with query expressions but works anywhere you can have `var`. `var` is followed by a binding pattern. You can also explicitly specify the type before the binding pattern without using var.

`{x}` is short for `{x: x}` in both binding patterns and record constructors.

::: code destructuring_records.bal :::

::: out destructuring_records.out :::

## Related links
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
