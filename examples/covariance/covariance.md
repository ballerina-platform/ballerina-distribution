# Covariance

Arrays and maps are covariant.
Static type-checking guarantees that the result of a read from a mutable
structure will be consistent with the static type.
Covariance means that a write to a mutable structure may result in a 
runtime error.
Arrays, maps, and records have an "inherent" type that constrains mutation.

::: code covariance.bal :::

::: out covariance.out :::