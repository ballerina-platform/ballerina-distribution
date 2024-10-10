# Error subtyping

If we want to check if a given `error` type (say `e1`) is a supertype of another `error` type (say `e2`), first we need to check if `e1` is a distinct error type. If it's not the case then `e1` is a supertype of `e2` if and only if the detail record type of `e1` is a supertype of the detail record type of `e2`.

If more explicit control over error type relations is desired you can use `distinct` error types. Each declaration of a distinct error type has a unique type ID. If the supertype is a `distinct` error type then there is the additional requirement that it must contain all the type IDs of the subtype. Note that you can create subtypes of distinct error types by intersecting them with other error types.

```ballerina 

::: code error_subtyping.bal :::

::: out error_subtyping.out :::

## Related links
- [Type intersection for error types](https://ballerina.io/learn/by-example/error-type-intersection/)
