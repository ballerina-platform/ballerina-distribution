# Distinct object types

Using the `distinct` keyword in the type definition creates distinct object types. This concept allows defining a type with nominal typing within a structured type system. This is useful when interacting with the external world through API interfaces like `GraphQL`. You may want to leverage nominal typing via this distinct typing feature of Ballerina.

Conceptually, a distinct type including another distinct type results in multiple interface inheritance.

::: code distinct_object_types.bal :::

::: out distinct_object_types.out :::

## Related links
- [Object values](/learn/by-example/object-values/)
- [Error subtyping](/learn/by-example/error-subtyping/)
- [Defining classes](/learn/by-example/defining-classes/)
- [Flexibly typed](https://ballerina.io/why-ballerina/flexibly-typed/)
