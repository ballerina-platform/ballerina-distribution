# Structured keys

Key fields can be structured as long as they belong to any subtype of plain data. The value of the key field
must be immutable. The initializer of the `readonly` field will be constructed as immutable. In other cases,
can use `cloneReadOnly()` to create an immutable value.

::: code structured_keys.bal :::

::: out structured_keys.out :::