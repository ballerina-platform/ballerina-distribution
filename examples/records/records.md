# Records

A `record` type has specific named fields. Fields can be accessed with `r.x`. Records are mutable. `r.x` is an
`lvalue`. Records can be constructed using a similar syntax to a `map`. Typically, a `record` type is combined
with a type definition. The name of the type is not significant. A `record` is just a collection of fields.
Record equality works the same as `map` equality.

::: code records.bal :::

::: out records.out :::