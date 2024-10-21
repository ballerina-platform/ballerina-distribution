# Raw templates

Raw template expressions are backtick templates without a tag (such as `string` or `xml`). This is a sequence of characters interleaved with interpolations within a pair of backticks (in the form`${expression}`). The result of evaluating such a raw template is a `RawTemplate` object that has two fields `(readonly & string[]) strings` and `(any|error)[] insertions`. The `strings` array will have string literals in the backtick string broken at interpolations and the `insertions` array will have the resultant values of evaluating each interpolation.

If you want to control the type of values used for interpolation more precisely, you can define an object type that includes the `RawTemplate` type and give a narrower type for the `insertions` fields. Then, the compiler will statically verify that the corresponding values used for interpolation belong to the desired type.

::: code raw_templates.bal :::

::: out raw_templates.out :::

## Related links
- [Backtick templates](https://ballerina.io/learn/by-example/backtick-templates/)
- [Object type inclusion](https://ballerina.io/learn/by-example/object-type-inclusion/)
