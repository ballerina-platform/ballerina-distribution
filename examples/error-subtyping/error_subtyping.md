# Error subtyping

If we want to identify if a given `error` type (say `ESub`) is a subtype of another error type (say `ESuper`), first we need to check if `ESuper` is a distinct error type. If it is not then `ESub` is a subtype if and only if the detail type of `ESub` is a subtype of the detail type of `ESuper`.

If more explicit control over error type relations is desired you can use `distinct` error types. Each declaration of a distinct error type has a unique type ID. If `ESuper` is a distinct error type there is the additional requirement that type ID of `ESub` must belong to the type ID set of `ESuper` for it to be a subtype.

Note that you can create subtypes of distinct error types by intersecting them with other error types.

::: code error_subtyping.bal :::

::: out error_subtyping.out :::

## Related links
- [Type intersection for error types](https://ballerina.io/learn/by-example/error-type-intersection/)
