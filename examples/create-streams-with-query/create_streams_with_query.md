# Creating tables with query

Query expression can be used to create streams. Query expression should be preceded by the `stream` keyword in this case. If the exprected stream type is `stream<T>` then the `select` clause must return values belonging to `T`.

When constructing stream from query expression, clauses in the query expression are executed lazily which are called as a result of next operations being performed on the constructed stream. The failure of check within the query will cause the stream to produce an error termination value.

::: code creating_tables_with_query.bal :::

::: out creating_tables_with_query.out :::

## Related links
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
