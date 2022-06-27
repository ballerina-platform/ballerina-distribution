# Covariance

Covariance means that a write to a mutable structure may result in a runtime error. Lists and mappings are covariant. Arrays, maps, tuples and records have an "inherent" type that constrains mutation. 

Static type-checking guarantees that the result of a read from a mutable structure will be consistent with the static type.

::: code covariance.bal :::

::: out covariance.out :::