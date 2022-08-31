# `typedesc` Type

The `typedesc` type is a built-in type that represents a type descriptor and is immutable (a subtype of readonly). It has a type parameter that describes the types that are described by the type descriptors that belong to that type descriptor. A `typedesc` value belongs to type `typedesc<T>` if the type descriptor describes a type that is a subtype of `T`.

::: code type_inference.bal :::

::: out type_inference.out :::