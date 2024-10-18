# Raw templates

Raw template is a backtick string without a tag (such as `string` or `xml`). Backtick string is a sequence of characters interleaved with interpolations (`${expression}`), wrapped by a pair of backticks. The result of evaluating such a raw template is a `RawTemplate` object that has two fields `(readonly & string[]) strings` and `(any|error)[] insertions`.  `strings` array will have string literals in the backtick string broken at interpolations and `insertions` array will have the resultant value of evaluating each interpolation.

::: code raw_templates.bal :::

::: out raw_templates.out :::
