# Converting from JSON to user-defined type

With mutable values, it would not be type-safe to allow a cast.
Mutable structures have the `inherent` type that limits mutation.
Cast to `T` will work on mutable structure `s` only if the `inherent` type
of `s` is a subtype of `T`.
Casting immutable values will work but it does not do numeric conversions.

::: code converting_from_json_to_user_defined_type.bal :::

::: out converting_from_json_to_user_defined_type.out :::