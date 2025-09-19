# Singleton types

A singleton type is a type that contains exactly one value. A singleton type is described using a compile-time constant expression. 

When the simple constant expression is a variable reference to a structured value, the value will be an immutable value. Therefore, a mutable value will not belong to any singleton type.

Unions of singletons enable the definition of more refined types, constraining the value space to include exactly the allowed values, and thereby, removing the need for explicit validation.

The type of a constant is a singleton type and a constant can be used as a singleton type. Enumerations are shorthand for unions of
string constants, and therefore, the members of an enumeration can also be used as singleton types.

::: code singleton_types.bal :::

::: out singleton_types.out :::

## Related links
- [Constants](/learn/by-example/const-and-final/)
- [Enumerations](/learn/by-example/enumerations/)
- [Immutability](/learn/by-example/immutability/)
