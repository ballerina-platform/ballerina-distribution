# Error subtyping

A given non-distinct `error` type (such as `InvalidIntDetail` in the example) is a supertype of another error type (say `InvalidI32Error`) if and only if the latter's detail record type (`InvalidIntDetail`) is super type of the former's detail type (`InvalidI32Detail`). 

If more explicit control over the error type relations is desired you can use `distinct` error types. Each declaration of a distinct error type has a unique type ID. For instance, the `DistinctIntError` and `AnotherDistinctIntError` have different type IDs. If the supertype is a `distinct` error type then there is the additional requirement that it must contain all the type IDs of the subtype.

::: code error_subtyping.bal :::

::: out error_subtyping.out :::

## Related links
- [Type intersection for error types](https://ballerina.io/learn/by-example/error-type-intersection/)
