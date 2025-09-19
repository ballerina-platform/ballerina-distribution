# Distinct object types

For more explicit control over object type relations you can use `distinct` object types. Each distinct object type declaration has a unique type ID. When you include a distinct object type within another object type declaration, the new type's type ID set will include the type IDs of the included type. When checking if a given object type `OSub` is a subtype of a distinct object type `OSuper` there is the additional requirement that the `OSub` type must contain all the type IDs of the `OSuper` type.

This way you can achieve the same behavior as a nominal type system within Ballerina's structured type system, which is useful to support features such as GraphQL API interfaces.

::: code distinct_object_types.bal :::

::: out distinct_object_types.out :::

## Related links
- [Object types](/learn/by-example/object-types/)
- [Error subtyping](/learn/by-example/error-subtyping/)
- [Defining classes](/learn/by-example/defining-classes/)
- [Flexibly typed](https://ballerina.io/why-ballerina/flexibly-typed/)
- [GraphQL service - Interfaces](https://ballerina.io/learn/by-example/graphql-interfaces/)
