# Error subtyping

`distinct` creates a new subtype and can be used to define subtypes of `error`. The name of the distinct `error` type can be used with the error constructor to create an `error` value of that type.

Even if the structure of the types is similar, they function as distinct types. The `is` operator can be used to distinguish distinct subtypes. Each occurrence of `distinct` has a unique identifier that is used to tag instances of the type.

::: code error_subtyping.bal :::

::: out error_subtyping.out :::

## Related Links
- [Errors](https://ballerina.io/learn/by-example/error-reporting/)
- [Error handling](https://ballerina.io/learn/by-example/error-handling/)
- [Check](https://ballerina.io/learn/by-example/check/)