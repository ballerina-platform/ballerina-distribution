# Immutability

`anydata` values can be made immutable. Simple and `string` values are inherently immutable.
A structural value can be constructed as mutable or immutable. A value includes an immutable flag.
The immutable flag is fixed at the time of construction. Attempting to mutate an immutable structure
causes a panic at runtime. Immutability is deep: an immutable structure can only have immutable
members. An immutable value is safe for concurrent access without locking.

::: code immutability.bal :::

::: out immutability.out :::