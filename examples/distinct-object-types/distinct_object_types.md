# Distinct object types

Using the `distinct` keyword in the type definition creates distinct object types. This concept allows to define a type with nominal typing within a structured type system. This is useful while interacting with the external world through API interfaces like `GraphQL`. You may want to leverage nominal typing via this distinct typing feature of Ballerina.

Conceptually, a distinct type including another distinct type results in multiple interface inheritance.

::: code distinct_object_types.bal :::

::: out distinct_object_types.out :::