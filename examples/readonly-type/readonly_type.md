# Readonly type

The `readonly` type consists of values that are immutable. For structural type `T`, `T & readonly` means
immutable `T`. `T & readonly` is a subtype of `T` and a subtype of `readonly`. Guaranteed that if declared
type of a value is a subtype of `readonly`, then at runtime the value can never be mutated. It is enforced
by runtime checks on the mutating structures. With `readonly` field, both the field and its value
are immutable.

::: code readonly_type.bal :::

::: out readonly_type.out :::