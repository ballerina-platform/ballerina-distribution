# Raw templates

Raw template expressions are backtick templates without a tag (such as `string` or `xml`). This is a sequence of characters interleaved with interpolations within a pair of backticks (in the form `${expression}`). The result of evaluating such a raw template is an `object:RawTemplate` object that has two fields `(readonly & string[]) strings` and `(any|error)[] insertions`. The `strings` array will have string literals in the backtick string broken at interpolations and the `insertions` array will have the resultant values of evaluating each interpolation.

If you want to control the type of the strings or the interpolations more precisely, you can define an object type that includes the `object:RawTemplate` type and override the relevant field(s) with narrower types. Then, the compiler will statically validate the values against the expected type(s).

An important use case of custom raw templates is SQL parameterized queries.

::: code raw_templates.bal :::

::: out raw_templates.out :::

## Related links
- [String templates](https://ballerina.io/learn/by-example/string-templates/)
- [RegExp type](https://ballerina.io/learn/by-example/regexp-type/)
- [Object type inclusion](https://ballerina.io/learn/by-example/object-type-inclusion/)
- [Database Access - Simple query](https://ballerina.io/learn/by-example/mysql-query-operation/)
