# Unions

`T1|T2` is the union of the sets described by `T1` and `T2`. `T?` is equivalent to `T|()`. Unions are untagged.

The `is` operator tests whether a value belongs to a specific type. The `is` operator in the condition causes the declared type to be narrowed.

::: code unions.bal :::

::: out unions.out :::