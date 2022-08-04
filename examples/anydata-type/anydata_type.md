# Anydata type

The type for plain data is `anydata`. It is a subtype of `any`. `==` and `!=` operators test for deep equality.
`x.clone()` returns a deep copy with the same mutability. `x.cloneReadOnly()` returns a deep copy that is
immutable. Ballerina syntax uses `readonly` to mean immutable. Both `x.clone()` and `x.cloneReadOnly()` do
not copy immutable parts of `x`. `const` structures are allowed. Equality and cloning handle cycles.

::: code anydata_type.bal :::

::: out anydata_type.out :::