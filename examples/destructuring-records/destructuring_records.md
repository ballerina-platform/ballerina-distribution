# Destructuring records

Destructuring records is particularly useful with query expressions but works anywhere you can have `var`.
`var` is followed by a `binding pattern`. The semantics of `binding pattern` is open. `{x}` is short for
`{x: x}` in both binding patterns and record constructors.

::: code destructuring_records.bal :::

::: out destructuring_records.out :::