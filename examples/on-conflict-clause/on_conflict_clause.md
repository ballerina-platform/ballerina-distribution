# Creating tables with query

When constructing a map or table with a key sequence using query expression,  there can be conflicting keys. on conflict clause can be specified after the select clause to handle these cases.

Syntax to write on conflict clause is `on conflict expression`. Type of the expression should be `error?`. If the result of evaluating the expression is an error, then the error will be the result. Otherwise, the old value is replaced by the new value.

::: code creating_tables_with_query.bal :::

::: out creating_tables_with_query.out :::

## Related links
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
